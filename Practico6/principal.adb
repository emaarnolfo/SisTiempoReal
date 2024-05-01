with Plan; use Plan;
with Ada.Text_IO; use Ada.Text_IO;
with proc; use proc;
with Ada.Text_IO; use Ada.Text_IO;


procedure principal is
    Procedimientos  :   array_ref_Procedimiento_t := (P1'Access, P2'Access, P3'Access, P4'Access);
    Tiempos         :   array_Tiempos_t(Procedimientos'Range);


begin

    Plan.Medir(Procedimientos, Tiempos);
    Put_line ("+--------------------------+");
    Put_Line ("| Procedimiento T.computo |");
    Put_line ("|--------------------------|");
    
    for I in Tiempos'Range loop
        --  Put ("| ");Put (I, Width=>13); Put (" ");
        --  Put (Tiempos(I), Width=> 9); Put (" |");
        Put_Line ("| " & I'Image & " | " & Tiempos(I)'Image & " |");
        -- New_Line;
    end loop;

    
    Put_line ("+--------------------------+");
    
end principal; 