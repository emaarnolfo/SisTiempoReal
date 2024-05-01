with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Execution_Time; use Ada.Execution_Time;

-- Paquete con cuatro procesos que demoran un tiempo determinado de CPU en ejecutarse
package body proc is 

    T_Inicio    :   CPU_Time;
    Dif         :   Time_Span   := Milliseconds(200);
    N : Natural;

    procedure P1 is  -- 400 ms 
    begin 
        T_Inicio := Clock;
        N := 0;

        while (dif*2) >= Clock - T_Inicio loop
            N := N+1;
        end loop;
        
    end P1;

    procedure P2 is -- 600 ms
    begin 
        T_Inicio := Clock;
        N := 0;

        while (dif*3) >= Clock - T_Inicio loop
            N := N+1;
        end loop;
    end P2;

    procedure P3 is -- 800 ms
    begin 
        T_Inicio := Clock;
        N := 0;

        while (dif*4) >= Clock - T_Inicio loop
            N := N+1;
        end loop;   
    end P3;

    procedure P4 is -- 800 ms
    begin 
        T_Inicio := Clock;
        N := 0;

        while (dif*4) >= Clock - T_Inicio loop
            N := N+1;
        end loop;
    end P4;

end proc;