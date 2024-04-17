with Ada.Real_Time, Ada.Text_IO, Sensor, Calefactor, pid;
use Ada.Real_Time, Ada.Text_IO, Sensor, Calefactor;

procedure principal2 is

    Kp : Float := 0.556481;
    Ki : Float := 3.20003;
    Kd : Float := 0.00008;
    muestreo : constant := 0.2;

    Start_Time, Current_Time : Time;
    Elapsed_Time : Time_Span;
    Siguiente_Instante : Time;
    Periodo: constant Time_Span := To_Time_Span(muestreo);

    Temp, Tref: Sensor.Temperaturas;
    U : Calefactor.Potencias;

    Archivo : File_Type;

    package Controlador_PID is new PID (Real => Float, 
                                        Entrada => Sensor.Temperaturas,
                                        Salida => Calefactor.Potencias);
    
    el_controlador : Controlador_PID.Controlador;

    package ES_Temperatura is new Ada.Text_IO.Float_IO(Sensor.Temperaturas);

begin
    Controlador_PID.Programar(el_controlador, Kp, Ki, Kd);
    
    Put("Introduce la temperatura de referencia: ");  
    ES_Temperatura.Get(Tref);

    Siguiente_Instante := Clock;
    Start_Time := Clock;

    Create(Archivo, Out_File, "Temperaturas2.txt");
    
    loop
        delay until Siguiente_Instante;
        
        Sensor.Leer(Temp);

        Controlador_PID.Controlar(el_controlador, Tref, Temp, U);

        Calefactor.Escribir(U);
        
        Put_Line(Float(Temp)'Image);
        Ada.Text_IO.Put_Line(Archivo, Float(Temp)'Image);

        Current_Time := Clock;
        Elapsed_Time := Current_Time - Start_Time;

        exit when Float(To_Duration(Elapsed_Time)) / 60.0 > 10.0;

        Siguiente_Instante := Siguiente_Instante + Periodo;

    end loop;

    Close(Archivo);

    Calefactor.Escribir(0.0);

    Put_Line("Fin del programa Principal2");

end principal2;