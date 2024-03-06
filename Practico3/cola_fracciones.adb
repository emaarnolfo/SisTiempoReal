with Ada.Text_IO; use Ada.Text_IO;
with Colas;                                             -- Se importa el paquete genérico Colas
with fracciones; use fracciones;                        -- Se importa el paquete fracciones

procedure cola_fracciones is

    package Cola_de_fracciones is new Colas (fracciones.fraccion_t, fracciones.Imprimir);   -- Instancia el paquete genérico Colas con el tipo definido en fracciones
    use Cola_de_fracciones;

    cola_fracciones: cola_t;                            -- Colas de fracciones

begin
    
    for I in 1..4 loop                                        
        for J in 1..4 loop
            Poner(I/J, cola_fracciones);                -- Se insertan fracciones en la cola
        end loop;
    end loop;

    MostrarCola (cola_fracciones);
end cola_fracciones;