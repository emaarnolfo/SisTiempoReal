with Ada.Text_IO; 
use Ada.Text_IO;


package body colas is 

    -- Funcion que agrega un nodo a la cola 
    procedure Poner (el_Elemento: elemento_t; en_la_Cola: in out cola_t) is 
        ptrAux : ref_Nodo := new Nodo;                          -- Creamos un nuevo nodo
    begin 
       
       ptrAux.Datos := el_Elemento;                             -- Asignamos el elemento al nodo
       ptrAux.ptr_Siguiente := null;                            -- El siguiente nodo es nulo        

        if Esta_Vacia(en_la_Cola) then                          -- Si la cola esta vacia, el nodo a agregar es el primero y el ultimo
            en_la_Cola.ptr_Primero := ptrAux;
            en_la_Cola.ptr_Ultimo := ptrAux;
        else                                                    -- Si la cola no esta vacia, el nodo se agrega al final de la cola
            en_la_Cola.ptr_Ultimo.ptr_Siguiente := ptrAux;
            en_la_Cola.ptr_Ultimo := ptrAux;
        end if;
    end Poner;

    -- Funcion que verifica si la cola esta vacia
    function Esta_Vacia(la_Cola: cola_t) return boolean is
    begin
        return la_Cola.ptr_Primero = null;
    end Esta_Vacia;

    -- Esta_LLena. Devuelve true si tiene un elemento
    function Esta_Llena(la_Cola: cola_t) return boolean is
    begin
        return la_Cola.ptr_Primero /= null;
    end Esta_Llena;

    -- Imprimir los nodos de la cola 
    procedure MostrarCola(la_Cola: cola_t) is
        ptrAux : ref_Nodo;
    begin
        ptrAux := la_Cola.ptr_Primero;

        loop
            Put(ToString(ptrAux.Datos));
            ptrAux := ptrAux.ptr_Siguiente;
            exit when ptrAux = null;
            Put(" - ");
        end loop;
    end MostrarCola;

    -- Funcion que compara dos colas diferentes
    function "=" (c1, c2: cola_t) return Boolean is
        ptrAux1, ptrAux2 : ref_Nodo;
    begin
        ptrAux1 := c1.ptr_Primero;
        ptrAux2 := c2.ptr_Primero;

        while ptrAux1 /= null and ptrAux2 /= null loop      -- Recorremos ambas colas y comparamos los datos de los nodos
            if ptrAux1.Datos /= ptrAux2.Datos then
                return false;
            end if;
            ptrAux1 := ptrAux1.ptr_Siguiente;
            ptrAux2 := ptrAux2.ptr_Siguiente;
        end loop;

        return ptrAux1 = null and ptrAux2 = null;           -- Si ambas colas tienen la misma cantidad de nodos, son iguales
    end "=";

    -- Funcion que copia una cola en otra
    procedure Copiar(Origen: cola_t; Destino: in out cola_t) is
        ptrAux : ref_Nodo := Origen.ptr_Primero;
    begin
        Vaciar(Destino);                                    -- Vaciamos la cola destino para eliminar basura de la memoria

        while ptrAux /= null loop                           -- Recorremos la cola origen y agregamos los nodos a la cola destino
            Poner(ptrAux.Datos, Destino);       
            ptrAux := ptrAux.ptr_Siguiente;
        end loop;
    end Copiar;

    -- Funcion que elimina el primer nodo de la cola
    procedure Quitar (un_Elemento: out elemento_t; de_la_Cola: in out cola_t) is
        ptrAux : ref_Nodo := de_la_Cola.ptr_Primero;
    begin
        de_la_Cola.ptr_Primero := ptrAux.ptr_Siguiente;
        un_Elemento := ptrAux.Datos;
        Delete_Node(ptrAux);                                -- Eliminamos el nodo de la memoria
    end Quitar;

    -- Funcion que vacia la cola y elimina los nodos de la misma
    procedure Vaciar(la_Cola: in out cola_t) is
        ptrAux : ref_Nodo;
        un_Elemento : elemento_t;
    begin
        ptrAux := la_Cola.ptr_Primero;

        while ptrAux /= null loop
            Quitar(un_Elemento, la_Cola);
            ptrAux := la_Cola.ptr_Primero;
        end loop;

        la_Cola.ptr_Ultimo := null;
    end Vaciar;


end colas;