with Ada.Text_IO; use Ada.Text_IO;
with Colas; -- Importa el paquete genérico Colas
with fracciones; use fracciones;-- Importa el paquete fracciones

procedure cola_fracciones is
    -- Instancia el paquete genérico Colas con el tipo definido en fracciones
    package Cola_de_fracciones is new Colas (fracciones.fraccion_t, fracciones.Imprimir);
    use Cola_de_fracciones;

    cola_fracciones: cola_t; -- Colas de fracciones
    --fraccion : fraccion_t; -- Fracción

begin
    -- null;
    for I in 1..4 loop
        for J in 1..4 loop
            Put(I'Image & "/" & J'Image & " ");
            New_Line;
            Poner(I/J, cola_fracciones);
        end loop;
    end loop;
    Put_Line("-------");
    MostrarCola (cola_fracciones);
end cola_fracciones;