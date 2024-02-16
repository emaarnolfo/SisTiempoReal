with Ada.Text_IO; 
use Ada.Text_IO;  

with Ada.Integer_Text_IO;


package body fracciones is 

    package Es_int is new Ada.Text_IO.Integer_IO(Integer);

    -- Recive dos fracciones y devuelve la SUMA de ambas fracciones
    function "+" (X, Y: fraccion_t) return fraccion_t is
        result : fraccion_t;
    begin
        result.numerador := (X.numerador * Y.denominador + Y.numerador * X.denominador);
        result.denominador := X.denominador * Y.denominador;
        return result;
    end "+";

    -- Recive una fraccione y devuelve el INVERSO  de la fraccion
    function "-" (X: fraccion_t) return fraccion_t is
    result : fraccion_t;
    begin
        result.numerador := - X.numerador;
        result.denominador := X.denominador;
        return result;
    end "-";

    -- Recive dos fracciones y devuelve la RESTA de ambas fracciones
    function "-" (X, Y: fraccion_t) return fraccion_t is
    result : fraccion_t;
    begin
        result := X + (-Y);
        return result;
    end "-";

    -- Recive dos fracciones y devuelve el PRODUCTO de ambas fracciones
    function "*" (X, Y: fraccion_t) return fraccion_t is
    result : fraccion_t;
    begin 
        result.numerador := X.numerador * Y.numerador;
        result.denominador := X.denominador * Y.denominador;
        return result;
    end "*";

    -- Recive dos fracciones y devuelve la DIVISION de ambas fracciones
    function "/" (X, Y: fraccion_t) return fraccion_t is   
    result : fraccion_t;
    num : Integer := X.numerador * Y.denominador;
    den : Integer := X.denominador * Y.numerador;
    begin
        if Y.numerador = 0 then
            Put("Error: Division por cero. ");
            result.numerador := 0;
            result.denominador := 1;
            return result;
        elsif den < 0 or num < 0 then
            result.numerador := -num;
            result.denominador := abs(den);
        else
            result.numerador := num;
            result.denominador := den;
        end if;

        result := Simplificar(result);
        return result;
    end "/";

    -- Recive dos fracciones y devuelve true si son IGUALES, false si no lo son
    function "=" (X, Y: fraccion_t) return boolean is
    begin
        if X.denominador * Y.numerador = X.numerador * Y.denominador then
            return true;
        else
            return false;
        end if;
    end "=";

    -- Funcion privada que me devuelve el maximo comun divisor de dos numeros. Se utiliza el algoritmo de Euclides
    function mcd (a, b: Integer) return Integer is
    begin
        if b = 0 then 
            return a;
        else
            return mcd(b, a mod b);
        end if;
    end mcd;

    -- Funcion privada que me simplifica una fraccion irreductible
    function Simplificar (F: fraccion_t) return fraccion_t is
    result : fraccion_t;
    begin
        result.numerador := F.numerador / mcd(F.numerador, F.denominador);
        result.denominador := F.denominador / mcd(F.numerador, F.denominador);
        return result;
    end Simplificar;

    -- Constructor de las fracciones. Recive dos enteros y devuelve una fraccion
    function "/" (X, Y: Integer) return fraccion_t is
    result : fraccion_t;
    begin
        if Y < 0 then
            result.numerador := -X;
        else 
            result.numerador := X;
        end if;
        result.denominador := abs(Y);

        result := Simplificar(result);
        return result;
    end "/";

    -- Proceso para leer una fraccion
    procedure Leer (F: out fraccion_t) is
    begin
        Es_int.Get(F.numerador);
        Es_int.Get(F.denominador);
    end Leer;

    -- Proceso para escribir una fraccion
    procedure Escribir (F: fraccion_t) is
    begin
        Ada.Integer_Text_IO.Put(Item => Integer(F.numerador), Width => 2);      Put(" /");
        Ada.Integer_Text_IO.Put(Item => Integer(F.denominador), Width => 2);    New_Line;
    end Escribir;


    -- Operaciones para obtener las partes de una fraccion
    function Numerador (F: fraccion_t) return Integer is
    begin 
        return F.numerador;
    end Numerador;

    function Denominador (F: fraccion_t) return Positive is
    begin 
        return F.denominador;
    end Denominador;


end fracciones;