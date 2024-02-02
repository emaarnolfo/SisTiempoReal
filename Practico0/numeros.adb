-- FILEPATH: /home/emanuel/uah/tiemporeal/TPsTiempoReal/Practico0/numeros.adb
-- BEGIN: ed8c6549bwf9
-- Este programa pretende ilustrar la forma de manejo de las herramientas
-- END: ed8c6549bwf9
-- del entorno de desarrollo en Ada.

-- Paquete est�ndar que vamos a manejar.
with Ada.Text_Io; use Ada.Text_Io;

-- Procedimiento principal.
procedure numeros is

   -- Creaci�n de ejemplares, para la entrada/salida de n�meros, a partir
   -- de los paquete gen�ricos "Ada.Text_Io.Integer_Io" y
   -- "Ada.Text_Io.Float_Io".
   package Ent_Es is new Ada.Text_Io.Integer_Io(Integer);
   package Real_Es is new Ada.Text_Io.Float_Io(Float);

   use Ent_Es;

   type Luz_de_Trafico is (Rojo, Amarillo, Verde);
   semaforo : Luz_de_Trafico := Rojo;
   package Sem_Es is new Ada.Text_Io.Enumeration_Io(Luz_de_Trafico);
   

   -- Declaraci�n de variables locales.
   I, J: Integer;
   X, Y: Float;

-- Cuerpo del procedimiento "Numeros".
begin
   -- Impresion del tipo de dato semaforo
   Sem_Es.Put(semaforo);
   New_Line;
   Put("EL tipo de semaforo es "&semaforo'Image);
   New_Line;

   Put("Indicar el tipo del semaforo: ");
   Sem_Es.Get(semaforo);
   Put("EL tipo de semaforo es "&semaforo'Image);
   New_Line;

   -- Entrada/salida de n�meros enteros.
   -- Lectura de datos
   New_Line;
   Put ("Introduce un n�mero entero: ");
   Ent_Es.Get (I);
   Put ("Introduce otro n�mero entero: ");
   Ent_Es.Get (J);
   New_Line;
   -- Presentaci�n de los resultados en el sistema decimal
   Ent_Es.Put (I); Put ('+');
   Ent_Es.Put (J); Put ('=');
   Put (I+J);
   New_Line;

   -- Presentaci�n de los resultados en binario
   Ent_Es.Put (I, Base => 2);
   Put ('+');
   Ent_Es.Put (J, Base => 2);
   Put ('=');
   Ent_Es.Put (I+J, Base => 2);
   New_Line;

   -- Presentaci�n de los resultados en hexadecimal
   Ent_Es.Put (I, Base => 16);
   Put ('+');
   Ent_Es.Put (J, Base => 16);
   Put ('=');
   Ent_Es.Put (I+J, Base => 16);
   New_Line;

   -- Presentaci�n de los resultados con formato
   Ent_Es.Put (I);
   Put ('+');
   Ent_Es.Put (J, Width => 0);
   Put ('=');
   Ent_Es.Put (I+J, Width => 6);
   New_Line;   New_Line;


   -- Entrada/salida de n�meros reales.
   -- Lectura de los datos
   Put ("Introduce un n�mero real: ");
   Real_Es.Get (X);
   Put ("Introduce otro n�mero real: ");
   Real_Es.Get (Y);
   New_Line;
   -- Presentaci�n de los resultados
   Real_Es.Put (X);  Put ('/');  Real_Es.Put (Y); Put ('=');
   Real_Es.Put (X/Y);
   New_Line;  
   -- Presentaci�n de los resultados con formato
   Real_Es.Put (X, Fore => 2, Aft => 2, Exp => 3);
   Put ('/');
   Real_Es.Put (Y, Fore => 0, Aft => 0, Exp => 0);
   Put ('=');
   Real_Es.Put (X/Y, Fore => 10, Aft => 4, Exp => 0);
   New_Line; New_Line;
end numeros;
