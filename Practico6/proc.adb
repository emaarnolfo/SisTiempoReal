with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;

package body proc is 

    N : Natural;

    procedure P1 is  -- 400 ms 
    begin 
        Put_Line("Tarea 1 en ejecucion");
        N := 0;
        for I in 1..400000000 loop
            N := N+1;
        end loop;
        Put_Line("Tarea 1 finalizada");
    end P1;

    procedure P2 is -- 600 ms
    begin 
        Put_Line("Tarea 2 en ejecucion");
        N := 0;
        for I in 1..600000000 loop
            N := N+1;
        end loop;
        Put_Line("Tarea 2 finalizada");
    end P2;

    procedure P3 is -- 800 ms
    begin 
        Put_Line("Tarea 3 en ejecucion");
        N := 0;
        for I in 1..800000000 loop
            N := N+1;
        end loop;
        Put_Line("Tarea 3 finalizada");
    end P3;

    procedure P4 is -- 800 ms
    begin 
        Put_Line("Tarea 4 en ejecucion");
        N := 0;
        for I in 1..800000000 loop
            N := N+1;
        end loop;
        Put_Line("Tarea 4 finalizada");
        null;
    end P4;

end proc;