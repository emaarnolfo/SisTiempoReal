with Sensor; with Calefactor;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;

procedure medir2 is

    Tiempo_Espera : constant := 0.2;
    Potencia : Calefactor.Potencias := 1000.00;
    T_ambiente : Sensor.Temperaturas := 25.0;
    --Temperatura : Sensor.Temperaturas := 86.6629;
    Cp : Float := 25.0;
    Ct : Float;
    ct_aux : Float;

    Periodo: constant Time_Span := To_Time_Span(Tiempo_Espera);
    t_actual, t_anterior : Sensor.Temperaturas;
    Siguiente_Instante: Time;
    Maxima_Variacion_Temp : Float := 0.0;
    Variacion_Temp : Float ;
    Regimen_Activo : Boolean := False;

begin
    Sensor.Leer(t_actual);
    
    Put_Line("Iniciando calentamiento con potencia = " & Potencia'Image & "W");
    Calefactor.Escribir(Potencia);
    Siguiente_Instante := Clock;    

    loop
        delay until Siguiente_Instante;

        t_anterior := t_actual;
        Sensor.Leer(t_actual);
        Variacion_Temp := Float(t_actual) - Float(t_anterior);
        
        if (not Regimen_Activo) and (Variacion_Temp /= 0.0) then
            Regimen_Activo := True;
        end if;

        if (Regimen_Activo) and Variacion_Temp /= 0.0 then 
            ct_aux := ((Float(Potencia) - Cp * (Float(t_actual) - Float(T_ambiente))) * Tiempo_Espera) / Variacion_Temp; 
            Put_Line("Capacidad termica actual con temperatura actual = " & ct_aux'Image & "C");
            
            if (Variacion_Temp > Maxima_Variacion_Temp) then
                Ct := ct_aux;
            end if;

        end if;
        
        exit when (Regimen_Activo) and (Variacion_Temp = 0.0);

        Siguiente_Instante := Siguiente_Instante + Periodo;

    end loop;
    
    Put_Line("Ct = " & ct_aux'Image & "W/C");
    Put_Line("Ct delta maximo = " & Ct'Image & "W/C");

    Calefactor.Escribir(0.0);

end medir2;
