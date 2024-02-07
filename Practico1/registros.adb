-- Trabajo Practico 1 
-- Alumno: Arnolfo Emanuel

with Ada.Text_IO; 
use Ada.Text_IO;

with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

with Ada.Text_IO.Unbounded_IO;
use Ada.Text_IO.Unbounded_IO;

procedure registros is
    package ES_int is new Ada.Text_IO.Integer_Io(Integer);

    -- Tipo de dato para el titulo de un libro    
    subtype titulo_t is Unbounded_string;

    -- Tipos de dato para formar una fecha completa
    type anio_t is range 1900..2100;
    type meses_t is (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre);
    type dia_t is range 1..31;

    -- Tipo de dato para la fecha de publicacion de la pelicula
    type fecha_t is record
        dia: dia_t;
        mes: meses_t;
        anio: anio_t;
    end record;

    -- Tipo de dato nota de 1 a 10 con rango de 0.1
    type promedio_t is delta 0.01 range 0.0..10.0;
    subtype nota_t is promedio_t delta 0.1 range 1.0..10.0;

    -- Tipo de dato para una pelicula, contiene su titulo, nota y fecha
    type pelicula_t is record
        titulo: titulo_t;
        fecha: fecha_t;
        nota: nota_t;
    end record;

    -- Tipo de dato para un array de peliculas
    type array_peliculas is array (integer range <>) of pelicula_t;
    type pArray_peliculas is access array_peliculas;

    -- Tipo de dato para manejar las excepciones
    type Return_t is (OK, Error);

    -- Paquetes para leer y escribir los datos de la fecha
    package ES_dia is new Ada.Text_IO.Integer_Io(dia_t);
    package ES_mes is new Ada.Text_IO.Enumeration_Io(meses_t);
    package ES_anio is new Ada.Text_IO.Integer_Io(anio_t);

    -- Paquete para leer y escribir la nota
    package ES_nota is new Ada.Text_IO.Fixed_Io(nota_t);


    -- Funcion para leer la fecha de publicacion de una pelicula
    procedure Get_fecha (p: in out pArray_peliculas; i : Positive; retval : out Return_t) is
    begin
        Put("Dia: ");   
        ES_dia.Get(p(i).fecha.dia);
        Put("Mes: ");   
        ES_mes.Get(p(i).fecha.mes);
        Put("Año: ");   
        ES_anio.Get(p(i).fecha.anio);
        retval := OK;
    exception
        when Constraint_Error =>
        Put_Line("Error: Fecha fuera de rango.");
        retval := Error;
        when others =>
        Put("La fecha ingresada no es valida. Intente nuevamente: ");New_Line;
        retval := Error;
    end Get_fecha;


    -- Puntero al array de peliculas
    v: pArray_peliculas;

    -- Auxiliares para saber en que posicion se encuentra la nota y fecha minima y maxima 
    nota_min  : integer := 1;
    nota_max  : integer := 1;
    fecha_min : integer := 1;
    fecha_max : integer := 1;


    n : integer;
    titulo: titulo_t;
    promedio : promedio_t := 0.0;
    retval : Return_t;

begin 
    -- Pedir por pantalla la cantidad de peliculas
    Put_Line("Ingrese la cantidad de peliculas: ");
    ES_int.Get(n);

    -- Crear un array de peliculas
    v := new array_peliculas(1..n);

    -- Recolectar los datos de las peliculas
    for i in 1..n loop
        Put("Ingrese el titulo de la pelicula " & i'Image & ": ");
        Skip_line;
        Get_Line(v(i).titulo);    
        Put_Line("Ingrese la fecha de publicacion de la pelicula: ");

        loop  -- Llamado a funcion con manejo de excepciones
            Get_fecha(v, i, retval);
            exit when retval = OK;
        end loop;
    
        Put_Line("Ingrese la nota: ");
        ES_nota.Get(v(i).nota);

        -- Calcular el promedio de las notas
        promedio := promedio + (v(i).nota / n);
        New_Line;
    end loop;

    for i in 1..n loop
        Put_Line("Pelicula " & i'Image);
        New_Line;
        Put_Line("Titulo: " & v(i).titulo);
        Put_Line("Fecha: " & v(i).fecha.dia'Image & " de " & v(i).fecha.mes'Image & " de " & v(i).fecha.anio'Image);
        Put_Line("Nota: " & v(i).nota'Image);
        Put_Line("");

        -- Almacena el indice de la pelicula con la nota mas baja y mas alta
        if v(i).nota < v(nota_min).nota then
            nota_min := i;
        end if;

        if v(i).nota > v(nota_max).nota then
            nota_max := i;
        end if;

        -- Almacena el indice de la pelicula con la fecha mas baja y mas alta
        if v(i).fecha.anio < v(fecha_min).fecha.anio then
            fecha_min := i;
        elsif v(i).fecha.anio = v(fecha_min).fecha.anio then
            if meses_t'Pos(v(i).fecha.mes) < meses_t'Pos(v(fecha_min).fecha.mes) then
                fecha_min := i;
            elsif v(i).fecha.mes = v(fecha_min).fecha.mes then
                if v(i).fecha.dia < v(fecha_min).fecha.dia then 
                    fecha_min := i;
                end if;
            end if;
        end if;

        if v(i).fecha.anio > v(fecha_max).fecha.anio then
            fecha_max := i;
        elsif v(i).fecha.anio = v(fecha_max).fecha.anio then
            if meses_t'Pos(v(i).fecha.mes) > meses_t'Pos(v(fecha_max).fecha.mes) then
                fecha_max := i;
            elsif meses_t'Pos(v(i).fecha.mes) = meses_t'Pos(v(fecha_max).fecha.mes) then
                if v(i).fecha.dia > v(fecha_max).fecha.dia then 
                    fecha_max := i;
                end if;
            end if;
        end if;
    
    end loop;

    -- Impresion de los resultados
    Put_Line("El promedio de las notas desde el" & v(fecha_min).fecha.dia'Image & " de " & v(fecha_min).fecha.mes'Image & " de" & v(fecha_min).fecha.anio'Image 
            & " hasta el " & v(fecha_max).fecha.dia'Image & " de " & v(fecha_max).fecha.mes'Image & " de" & v(fecha_max).fecha.anio'Image 
            & " es de:" & promedio'Image);

    Put_Line("Nota Minima:" & v(nota_min).nota'Image & 
             " Pelicula: "   & v(nota_min).titulo &
             ". Estrenada el:" & v(nota_min).fecha.dia'Image & " de " & v(nota_min).fecha.mes'Image & " de" & v(nota_min).fecha.anio'Image);
    Put_Line("Nota Maxima:" & v(nota_max).nota'Image & 
             " Pelicula: "   & v(nota_max).titulo &
             ". Estrenada el:" & v(nota_max).fecha.dia'Image & " de " & v(nota_max).fecha.mes'Image & " de" & v(nota_max).fecha.anio'Image);

end registros;
