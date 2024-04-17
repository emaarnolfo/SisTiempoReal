with Ada.Text_IO, Sensor, Calefactor, Ada.Real_Time, PID; 
use Sensor, Ada.Text_IO, Ada.Real_Time;


procedure principal is 
    
    Temp_amb, Temp_prev, Temp, Temp_en_delta: Temperaturas; 
    L, Tiempo_en_delta, pendiente : Float;
    Potencia : Float := 1000.0;

    Temp_delta, Temp_delta_max, ord_origen : Float;
    Kp, Ki, Kd, tao : Float;

    Start_time, Stop_time, Next_time  : Time;
    Elapsed_time                      : Time_Span;
    Delta_time                        : Time_Span   := Milliseconds(200);
    
    Archivo: File_Type;

begin 

    Sensor.Leer(Temp_amb);
    Temp_prev := Temp_amb;
    Ada.Text_IO.Put_Line("Temp_amb: " & Temp_amb'Image);

    Calefactor.Escribir(Calefactor.Potencias(Potencia));
    Start_time := Clock;


-- *****************************************************************************
-- Sacar tiempo de respuesta. (L)
    loop
        Sensor.Leer(Temp);

        if Temp /= Temp_prev then
            --Ada.Text_IO.Put_Line("Temp_amb: " & Temp_amb'Image);
            -- Split(T => Now, SC => Count, TS => Sub);
            Stop_time := Clock;
            Elapsed_time := Stop_time - Start_time;

            --Put_Line("Elapse_time: " & Duration'Image(To_Duration(Elapsed_time)));
            
            L := Float(To_Duration(Elapsed_time));
            Ada.Text_IO.Put_Line("Tiempo de respuesta: " & L'Image & "[s]");
            Temp_prev := Temp;
            exit;
        end if;

        Temp_prev := Temp;
    end loop;

-- *****************************************************************************
-- Sacar Delta maximo. Con la Temp y el tiempo en ese punto
    Temp_delta_max := 0.0;
    Next_time := Clock;

    delay(To_Duration(Milliseconds(100)));
    Temp_prev := Temp;
    
    loop
        Sensor.Leer(Temp);
        --Put_Line("Temperatura: " & Temp'Image);
        --Put_Line("Temperatura_Previa: " & Temp_prev'Image);

        Temp_delta := Float(Temp) - Float(Temp_prev);
        if Temp_delta > Temp_delta_max then
            Temp_delta_max := Temp_delta;
            Stop_time := Clock;
            Elapsed_time := Stop_time - Start_time;
            -- Tiempo donde la pendiente es maxima. Se utiliza luego para sacar las intersecciones
            Tiempo_en_delta := Float(To_Duration(Elapsed_time));
            Temp_en_delta := Temp;  
            pendiente := Temp_delta_max / Float(To_Duration(Delta_time));
            --  Put_Line("Temp_delta_max: " & Temp_delta_max'Image);
            --  Put_Line("Tiempo_en_delta: " & Tiempo_en_delta'Image);
            --  Put_Line("");
        end if;


        -- Verificar que no este en estado transitorio
        if Temp_delta < 0.01 then
            Ada.Text_IO.Put_Line("Pendiente: " & pendiente'Image);
            Ada.Text_IO.Put_Line("Tiempo en delta maximo: " & Tiempo_en_delta'Image);
            Ada.Text_IO.Put_Line("Temperatura en delta maximo: " & Temp_en_delta'Image);
            exit;
        end if;
        
        Temp_prev := Temp;
        
        Next_time := Next_time + Delta_time;
        --Put_Line("Next_time: " & Next_time'Image);
        Put_Line("Temperatura: " & Temp'Image);
        delay until Next_time;
    end loop;

-- *****************************************************************************

-- Obtener el valor de la ordenada de origen
-- y = ax + b
-- donde a es la pendiente y b es la ordenada de origen
-- los valores de x y y son los valores de la Temp y el tiempo en el punto de maxima pendiente
-- los cuales se sacaron anteriormente.
-- Entonces b = y - a*x

    ord_origen := Float(Temp_en_delta) - pendiente * Tiempo_en_delta;

-- Con la ordenada de origen y la pendiente se puede sacar la interseccion
-- entre la temperatura luego del regimen transitorio y la recta de la pendiente maxima.
-- Este valor se corresponde a tao + L. Donde L es el tiempo de respuesta calculado al principio
-- x = (y - b) / a

    tao := (Float(Temp) - ord_origen / pendiente) - L;

-- Una vez obtenidos tao, K (temperatura estable) y L (tiempo de respuesta) se puede sacar
-- los valores de Kp, Ki y Kd según la tabla de Ziegler-Nichols

    Kp := 1.2 * tao/(Float(Temp) * L);
    Ki := 2.0 * L;
    Kd := 0.5 * L;

    Ada.Text_IO.Put_Line("Kp = " & Kp'Image);
    Ada.Text_IO.Put_Line("Ki = " & Ki'Image);
    Ada.Text_IO.Put_Line("Kd = " & Kd'Image);
    Ada.Text_IO.Put_Line("pendiente = " & pendiente'Image);
    Ada.Text_IO.Put_Line("ord_origen = " & ord_origen'Image);

    Create(Archivo, Out_File, "Constantes.txt");

    Ada.Text_IO.Put_Line(Archivo, "K = " & Temp'Image);
    Ada.Text_IO.Put_Line(Archivo, "tao = " & tao'Image);
    Ada.Text_IO.Put_Line(Archivo, "L = " & L'Image);
    Ada.Text_IO.Put_Line(Archivo, "Kp = " & Kp'Image);
    Ada.Text_IO.Put_Line(Archivo, "Ki = " & Ki'Image);
    Ada.Text_IO.Put_Line(Archivo, "Kd = " & Kd'Image);

    Close(Archivo);

    Put_Line("Fin del programa Principal1");

end principal;