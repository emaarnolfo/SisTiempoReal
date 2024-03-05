with Ada.Unchecked_Deallocation;

generic
    type elemento_t is private;
    with function ToString(el_Elemento: elemento_t) return string;

package Colas is 
    type cola_t is limited private;

    procedure Poner (el_Elemento: elemento_t; en_la_Cola: in out cola_t);
    procedure Quitar (un_Elemento: out elemento_t; de_la_Cola: in out cola_t);
    function Esta_Vacia (la_Cola: cola_t) return Boolean;
    --  function Esta_Llena (la_Cola: cola_t) return Boolean;
    procedure MostrarCola(la_Cola: cola_t);

    procedure Copiar (Origen: cola_t; Destino: in out cola_t);
    function "=" (c1, c2: cola_t) return Boolean;
    
    procedure Vaciar(la_Cola: in out cola_t);

private 
    -- Definicion del tipo cola_t"
    -- En esta ocasión se implementa una cola dinámica
    type Nodo;
    type ref_Nodo is access Nodo;

    type Nodo is record
        Datos: elemento_t;
        ptr_Siguiente: ref_Nodo;
    end record;
    
    type cola_t is record
        ptr_Primero, ptr_Ultimo: ref_Nodo;
    end record;

    procedure Delete_Node is new Ada.Unchecked_Deallocation (Nodo, ref_Nodo);

end Colas;