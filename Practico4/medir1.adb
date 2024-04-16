with Ada.Text_IO, Sensor, Calefactor, Ada.Real_Time; 
use Sensor;
use Ada.Text_IO, Ada.Real_Time;


procedure medir1 is 
    
    T_Ambiente, Temperatura_prev, Temperatura: Temperaturas; 
    L, Cp : Float;
    Potencia : Float := 1000.0;

    Now : Ada.Real_Time.Time;
    Count : Ada.Real_Time.Seconds_Count;
    Sub   : Ada.Real_Time.Time_Span;

    Archivo: File_Type;

begin 

    Sensor.Leer(Temperatura);
    T_Ambiente := Temperatura;
    Ada.Text_IO.Put_Line("T_Ambiente: " & T_Ambiente'Image);

    Calefactor.Escribir(Calefactor.Potencias(Potencia));
    Now := Clock;


    loop
        Temperatura_prev := Temperatura;
        Sensor.Leer(Temperatura);

        if Temperatura /= Temperatura_prev then
            --Ada.Text_IO.Put_Line("T_Ambiente: " & T_Ambiente'Image);
            Split(T => Now, SC => Count, TS => Sub);
            L := Float(Count);
            Ada.Text_IO.Put_Line("Tiempo de respuesta: " & L'Image);
            exit;
        end if;
    end loop;

    -- Espero el tiempo de respuesta del horno
    delay(2.0);
    
    loop 
        Temperatura_prev := Temperatura;
        Sensor.Leer(Temperatura);
        delay (0.5);

        if Temperatura_prev = Temperatura then
            Cp := Potencia / Float((Temperatura - T_Ambiente));
            Ada.Text_IO.Put_Line("Coeficiente de perdidas Cp = " & Cp'Image);
            exit;
        end if;

    end loop;

    Create(Archivo, Out_File, "Constantes.txt");

    Ada.Text_IO.Put_Line(Archivo, "T_Ambiente = " & T_Ambiente'Image);
    Ada.Text_IO.Put_Line(Archivo, "Tiempo de respuesta = " & L'Image);
    Ada.Text_IO.Put_Line(Archivo, "Cp = " & Cp'Image);

    Close(Archivo);

    Put_Line("Fin del programa Medir1");

end medir1;