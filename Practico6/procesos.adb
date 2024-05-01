with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Execution_Time; use Ada.Execution_Time;

package body procesos is 

    T_Inicio    :   CPU_Time;
    Dif         :   Time_Span   := Milliseconds(200);
    N : Natural;

    procedure P1 is  -- 400 ms 
    begin 
        T_Inicio := Clock;
        -- Put_Line("Tarea 1 en ejecucion");
        N := 0;

        while (dif*2) >= Clock - T_Inicio loop
            N := N+1;
        end loop;
        -- Put_Line("Tarea 1 finalizada");
    end P1;

    procedure P2 is -- 600 ms
    begin 
        T_Inicio := Clock;
        -- Put_Line("Tarea 2 en ejecucion");
        N := 0;
        while (dif*3) >= Clock - T_Inicio loop
            N := N+1;
        end loop;
        -- Put_Line("Tarea 2 finalizada");
    end P2;

    procedure P3 is -- 800 ms
    begin 
        T_Inicio := Clock;
        -- Put_Line("Tarea 3 en ejecucion");
        N := 0;
        while (dif*4) >= Clock - T_Inicio loop
            N := N+1;
        end loop;
        -- Put_Line("Tarea 3 finalizada");
    end P3;

    procedure P4 is -- 800 ms
    begin 
        T_Inicio := Clock;
        -- Put_Line("Tarea 4 en ejecucion");
        N := 0;
        while (dif*4) >= Clock - T_Inicio loop
            N := N+1;
        end loop;
        -- Put_Line("Tarea 4 finalizada");
        null;
    end P4;

end procesos;