with Ada.Text_IO; use Ada.Text_IO;
with Ada.Execution_Time; use Ada.Execution_Time;
with Ada.Real_Time; use Ada.Real_Time;

package body Plan is

    procedure Medir (Procedimientos: array_ref_Procedimiento_T; Tiempos : out array_Tiempos_t) is
    
        T_Inicio        :   CPU_Time;
        T_Ejecucion     :   Time_Span;
        --computo         :   Natural;
        
    begin
        for I in Procedimientos'Range loop    

            T_Inicio := Clock;
            Procedimientos(I).all;
            T_Ejecucion := Clock - T_Inicio;

            --computo := Natural(To_Duration(T_Ejecucion));
            Tiempos(I) := Natural(To_Duration(T_Ejecucion));
            Put_Line("Tiempo de ejecucion: " & Tiempos(I)'Image);

        end loop;
    end Medir;
end Plan;