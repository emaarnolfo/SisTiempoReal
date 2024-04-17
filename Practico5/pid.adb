with Ada.Text_IO; use Ada.Text_IO;

package body pid is 
    procedure Programar (el_Controlador: in out Controlador; Kp, Ki, Kd: in Real) is
    begin
        el_Controlador.Kp := Kp;
        el_Controlador.Ki := Ki;
        el_Controlador.Kd := Kd;
    end Programar;

    procedure Controlar (con_el_Controlador: in out Controlador; 
                                       R, C: in     Entrada; 
                                          U:    out Salida) is
        Error, Derivada : Real;
        muestreo : Real := 0.2;
    begin
        Error := Real(R-C);

        -- sum e(k). Acumulado de los errores
        con_el_Controlador.S_Anterior := con_el_Controlador.S_Anterior + con_el_Controlador.Error_Anterior;

        -- e(n) - e(n-1)
        Derivada := Error - con_el_Controlador.Error_Anterior;
        -- e(n-1)
        con_el_Controlador.Error_Anterior := Error;

        --Put_Line("Antes de U");
        U := Salida(con_el_Controlador.Kp * (Error + 
             Real((Real(1)/con_el_Controlador.Ki) * con_el_Controlador.S_Anterior * Real(muestreo)) + 
             Real((con_el_Controlador.Kd * Derivada)/Real(muestreo))));
        --Put_Line("Despues de U");
    
    end Controlar;


end pid;