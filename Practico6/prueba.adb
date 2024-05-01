with Ada.Text_IO, proc; --, Plan;
use Ada.Text_IO, proc; --, Plan;

--  procedure prueba is
--      package Integer_Es is new Integer_Io (Integer);
--      use Integer_Es;
--      Tareas: array_reg_Planificacion_t := (
--          -- ---------------------------------------------------------
--          -- Tarea T   D   C   P   R   PLANIFICABLE
--          -- ----- ------------------------------------------------
--              (1,  20, 20, 3,  1,  0,  False),
--              (2,  20,  5, 3,  1,  0,  False),
--              (3,  15, 15, 3,  1,  0,  False),
--              (4,  10, 10, 4,  1,  0,  False)
--                                              );

procedure prueba is 

begin 
   
    Put_Line("Procedure 1");
    proc.P1;
    New_Line;
   
    Put_Line("Procedure 1");
    proc.P2;
    New_Line;
    
    Put_Line("Procedure 1");
    proc.P3;
    New_Line;
    
    Put_Line("Procedure 1");
    proc.P4;
    New_Line;

end prueba;