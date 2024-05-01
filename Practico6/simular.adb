with Ada.Text_IO, plan, procesos, Ada.Real_Time, Ada.Task_Identification;
use Ada.Text_IO, plan, procesos, Ada.Real_Time, Ada.Task_Identification;


procedure simular is
    type ref_Procedimiento_t is access procedure;

    task type Tarea_t (Nombre   : Natural;
                       T        : Natural;
                       D        : Natural;
                       C        : Natural;
                       P        : Natural;
                       Codigo_ciclico : ref_Procedimiento_t) is
                       pragma Priority (P);
    end Tarea_t;

    Tarea1: Tarea_t (1, 2400,  600, 400, 4, P1'Access);
    Tarea2: Tarea_t (2, 3200, 1200, 600, 3, P2'Access);
    Tarea3: Tarea_t (3, 3600, 2000, 800, 2, P3'Access);
    Tarea4: Tarea_t (4, 4000, 3200, 800, 1, P4'Access);

    Abortar : Boolean := False;
    
    task body Tarea_t is
        Periodo : Time := Clock + Milliseconds(T);
        Deadline : Time;
        Tiempo_Simulacion : Time := Clock;
        
    begin
        Periodo := Clock;
        loop
            exit when Abortar;
            delay until(Periodo);
            Deadline := Clock + Milliseconds(D);
            select
                delay until (Deadline);  
                Put_Line("No se ha cumplido el Deadline" & Nombre'Image);
            then abort
                Codigo_ciclico.all;
            end select;

            Periodo := Periodo + Milliseconds(T);
        end loop;
        Put_line("Fin de la tarea" & Nombre'Image);
    end Tarea_t;

begin
    delay 50.0;
    Abortar := True;
    Put_Line("Fin de la simulacion");

end simular;


