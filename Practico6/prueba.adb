with Ada.Text_IO, Plan;  use Ada.Text_IO, Plan; 
with proc;               use proc;

procedure prueba is
    
    package Integer_Es is new Integer_Io (Integer);     use Integer_Es;
  
    Tareas: array_reg_Planificacion_t := (
        -- ---------------------------------------------------------
        -- Tarea T   D   C   P   R   PLANIFICABLE
        -- ----- ------------------------------------------------
            (1,  20, 20, 3,  1,  0,  False),
            (2,  20,  5, 3,  1,  0,  False),
            (3,  15,  7, 3,  1,  0,  False),
            (4,  10, 10, 4,  1,  0,  False) );

    Procedimientos  :   array_ref_Procedimiento_t := (P1'Access, P2'Access, P3'Access, P4'Access);
    Tareas2 : array_reg_Planificacion_t := (
        -- ---------------------------------------------------------
        -- Tarea   T     D   C   P   R   PLANIFICABLE
        -- ----- ------------------------------------------------
            (1,  2400,  600, 1,  1,  0,  False),
            (2,  3200, 1200, 1,  1,  0,  False),
            (3,  3600, 2000, 1,  1,  0,  False),
            (4,  4000, 3200, 1,  1,  0,  False) );

begin

    Put_line ("Ejemplo 1");
    Planificar(Tareas);
    Put_line (
    "+---------------------------------------------------+");
    Put_Line (
    "| Tarea    T     D      C     P    R   Planificable |");
    Put_line (
    "|---------------------------------------------------|");
    for I in Tareas'Range loop
        Put ("| ");
        Put (Tareas(I).Nombre, Width=>5); Put (" ");
        Put (Tareas(I).T, Width=>5); Put (" ");
        Put (Tareas(I).D, Width=>5); Put (" ");
        Put (Tareas(I).C, Width=>5); Put (" ");
        Put (Tareas(I).P, Width=>5); Put (" ");
        Put (Tareas(I).R, Width=>5); Put (" ");
        
        if Tareas(I).Planif then
            Put_Line ("       SI     |");
        else
            Put_Line ("       NO     |");
        end if;

    end loop;
    Put_line (
    "+---------------------------------------------------+");

    Put_line ("Ejemplo 2");
    Plan.Medir(Procedimientos, Tareas2);
    Planificar(Tareas2);

    Put_line (
    "+---------------------------------------------------+");
    Put_Line (
    "| Tarea    T     D      C     P    R   Planificable |");
    Put_line (
    "|---------------------------------------------------|");
    for I in Tareas2'Range loop
        Put ("| ");
        Put (Tareas2(I).Nombre, Width=>5); Put (" ");
        Put (Tareas2(I).T, Width=>5); Put (" ");
        Put (Tareas2(I).D, Width=>5); Put (" ");
        Put (Tareas2(I).C, Width=>5); Put (" ");
        Put (Tareas2(I).P, Width=>5); Put (" ");
        Put (Tareas2(I).R, Width=>5); Put (" ");
        
        if Tareas2(I).Planif then
            Put_Line ("       SI     |");
        else
            Put_Line ("       NO     |");
        end if;

    end loop;
    Put_line (
    "+---------------------------------------------------+");

end prueba;