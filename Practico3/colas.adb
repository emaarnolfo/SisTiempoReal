with Ada.Text_IO; 
use Ada.Text_IO;



package body colas is 

    procedure Poner (el_Elemento: elemento_t; en_la_Cola: in out cola_t) is 
        ptrAux : ref_Nodo := new Nodo;
    begin 
       
       ptrAux.Datos := el_Elemento;
       ptrAux.ptr_Siguiente := null;

        if Esta_Vacia(en_la_Cola) then
            en_la_Cola.ptr_Primero := ptrAux;
            en_la_Cola.ptr_Ultimo := ptrAux;
        else
            en_la_Cola.ptr_Ultimo.ptr_Siguiente := ptrAux;
            en_la_Cola.ptr_Ultimo := ptrAux;
        end if;
    end Poner;

    procedure Quitar (un_Elemento: out elemento_t; de_la_Cola: in out cola_t) is
        ptrAux : ref_Nodo;
        ptrSig : ref_Nodo;
        indice : Integer := 0;
    begin
        ptrAux := de_la_Cola.ptr_Primero;               
        ptrSig := ptrAux.ptr_Siguiente;
        
        if de_la_Cola.ptr_Primero.Datos = un_Elemento then          -- Se elimina el primero de la cola
            de_la_Cola.ptr_Primero := ptrAux.ptr_Siguiente;
            Delete_Node(ptrAux);
            Put_Line("Eliminado el indice " & Integer'Image(indice) & " de la cola");
        else                                                        -- Se recorre el resto de la lista
            while ptrAux /= null loop
                if ptrSig.Datos = un_Elemento then
                    ptrAux.ptr_Siguiente := ptrSig.ptr_Siguiente;
                    Delete_Node(ptrSig);
                    Put_Line("Eliminado el indice " & Integer'Image(indice) & " de la cola");
                end if;
                ptrAux := ptrSig;
                ptrSig := ptrSig.ptr_Siguiente;

                indice := indice + 1;
            end loop;
        end if;

    end Quitar;

    -- Funcion que verifica si la cola esta vacia
    function Esta_Vacia(la_Cola: cola_t) return boolean is
    begin
        return la_Cola.ptr_Primero = null;
    end Esta_Vacia;

    -- Funcion muestra la cola
    procedure MostrarCola(la_Cola: cola_t) is
        ptrAux : ref_Nodo;
    begin
        ptrAux := la_Cola.ptr_Primero;

        -- Put_Line("Elementos de la cola: ");

        while ptrAux /= null loop
            Put(ToString(ptrAux.Datos));
            ptrAux := ptrAux.ptr_Siguiente;
        end loop;
    end MostrarCola;

    -- Funcion que compara dos colas diferentes
    function "=" (c1, c2: cola_t) return Boolean is
        ptrAux1, ptrAux2 : ref_Nodo;
    begin
        ptrAux1 := c1.ptr_Primero;
        ptrAux2 := c2.ptr_Primero;

        while ptrAux1 /= null and ptrAux2 /= null loop
            if ptrAux1 /= ptrAux2 then
                return false;
            end if;
            ptrAux1 := ptrAux1.ptr_Siguiente;
            ptrAux2 := ptrAux2.ptr_Siguiente;
        end loop;

        return ptrAux1 = null and ptrAux2 = null;
    end "=";

    -- Funcion que copia una cola en otra
    procedure Copiar(Origen: cola_t; Destino: in out cola_t) is
    begin
        Vaciar(Destino);    -- Vaciamos la cola destino para eliminar basura de la memoria

        Destino.ptr_Primero := Origen.ptr_Primero;
        Destino.ptr_Ultimo := Origen.ptr_Ultimo;
    end Copiar;

    -- Funcion que vacia la cola y elimina los nodos de la misma
    procedure Vaciar(la_Cola: in out cola_t) is
        ptrAux : ref_Nodo;
    begin
        ptrAux := la_Cola.ptr_Primero;

        while ptrAux /= null loop
            la_Cola.ptr_Primero := ptrAux.ptr_Siguiente;
            Delete_Node(ptrAux);
            ptrAux := la_Cola.ptr_Primero;
        end loop;

        la_Cola.ptr_Ultimo := null;
    end Vaciar;

end colas;