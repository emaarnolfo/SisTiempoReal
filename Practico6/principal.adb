with Plan; use Plan;
with Ada.Text_IO; use Ada.Text_IO;
with proc; use proc;
with Ada.Text_IO; use Ada.Text_IO;


procedure principal is
    Procedimientos  :   array_ref_Procedimiento_t := (P1'Access, P2'Access, P3'Access, P4'Access);
    Tiempos         :   array_Tiempos_t(Procedimientos'Range);

    package ES_tiempos is new Ada.Text_IO.Integer_IO(Positive);

begin

    Plan.Medir(Procedimientos, Tiempos);
    Put_line ("+---------------------------+");
    Put_Line ("| Procedimiento | T.computo |");
    Put_line ("|---------------------------|");
    
    for I in Tiempos'Range loop
        Put ("| "); ES_tiempos.Put (Item => I, Width => 13); Put (" |");
        ES_tiempos.Put(Item => Tiempos(I), Width => 10); Put (" |");   
        New_Line;
    end loop;

    Put_line ("+---------------------------+");
    
end principal; 