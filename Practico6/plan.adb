with Ada.Text_IO; use Ada.Text_IO;
with Ada.Execution_Time; use Ada.Execution_Time;
with Ada.Real_Time; use Ada.Real_Time;

package body Plan is

    -- Procedimiento para medir el tiempo de CPU que demora cada procedimiento
    procedure Medir (Procedimientos: array_ref_Procedimiento_T; Tiempos : out array_Tiempos_t) is  
        T_Inicio        :   CPU_Time;
        T_Ejecucion     :   Time_Span;
        
    begin
        for I in Procedimientos'Range loop    
            T_Inicio := Clock;
            Procedimientos(I).all;              --Se llama al procedimiento
            T_Ejecucion := Clock - T_Inicio;

            -- Se calcula el tiempo de ejecucion en milisegundos y se guarda en el array de tiempos
            Tiempos(I) := Natural(To_Duration(T_Ejecucion)*1000);
        end loop;
    end Medir;

    -- Calcula la Prioridad P, el tiempo de respuesta R y si es planificable
    procedure Planificar (Tareas: in out array_reg_Planificacion_t) is
        n : Natural;
        w, w_new: Float;

    begin
        --Asignar prioridad segun el siguiente criterio: Si Di < Dj entonces Pi > Pj
        for I in Tareas'Range loop
            Tareas(I).P := 1;
            for J in Tareas'Range loop
                if Tareas(I).D < Tareas(J).D then
                    Tareas(I).P := Tareas(I).P + 1;
                end if;
                if Tareas(I).D = Tareas(J).D then
                    if Tareas(I).T < Tareas(J).T then
                        Tareas(I).P := Tareas(I).P + 1;
                    end if;
                end if;
            end loop;
        end loop;

        --Calcula el tiempo de respuesta R
        for I in Tareas'Range loop
            n := 0;
            w := Float(Tareas(I).C);

            while true loop

                w_new := Float(Tareas(I).C);

                for J in Tareas'Range loop
                    if Tareas(J).P > Tareas(I).P then
                        w_new := w_new + (Float'Ceiling((w)/Float(Tareas(J).T)))*Float(Tareas(J).C);
                    end if;
                end loop;
                
                if w = w_new then
                    Tareas(I).R := Natural(w_new);
                    Tareas(I).Planif := True;
                    exit;
                end if;

                if Natural(w_new) > Tareas(I).D then
                    Tareas(I).R := Natural(w_new);
                    Tareas(I).Planif := False;
                    exit;
                end if;

                w := w_new;
                n := n + 1;
            end loop;
        end loop;              
    end Planificar;

    procedure Medir (Procedimientos: in array_ref_Procedimiento_t; Tareas: in out array_reg_Planificacion_t) is
        Tiempos : array_Tiempos_t(Procedimientos'Range);
        
        package Es_tiempos is new Ada.Text_IO.Integer_IO(Positive);
    begin

        Medir(Procedimientos, Tiempos);

        Put_line ("+---------------------------+");
        Put_Line ("| Procedimiento | T.computo |");
        Put_line ("|---------------------------|");
        for I in Tiempos'Range loop
            Put ("| "); ES_tiempos.Put (Item => I, Width => 13); Put (" |");
            ES_tiempos.Put(Item => Tiempos(I), Width => 10); Put (" |");   
            New_Line;
        end loop;
        Put_line ("+---------------------------+");

        for I in Tareas'Range loop
            Tareas(I).C := Tiempos(I);
        end loop;
    end Medir;
end Plan;