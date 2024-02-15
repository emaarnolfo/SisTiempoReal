with Ada.Text_IO; 
use Ada.Text_IO;  

with Ada.Integer_Text_IO;


package body fracciones is 

    package Es_int is new Ada.Text_IO.Integer_IO(Integer);

    function "+" (X, Y: fraccion_t) return fraccion_t is
        result : fraccion_t;
    begin
        result.numerador := (X.numerador * Y.denominador + Y.numerador * X.denominador);
        result.denominador := X.denominador * Y.denominador;
        return result;
    end "+";

    function "-" (X: fraccion_t) return fraccion_t is
    result : fraccion_t;
    begin
        result.numerador := - X.numerador;
        result.denominador := X.denominador;
        return result;
    end "-";

    function "-" (X, Y: fraccion_t) return fraccion_t is
    result : fraccion_t;
    begin
        result := X + (-Y);
        return result;
    end "-";

    function "*" (X, Y: fraccion_t) return fraccion_t is
    result : fraccion_t;
    begin 
        result.numerador := X.numerador * Y.numerador;
        result.denominador := X.denominador * Y.denominador;
        return result;
    end "*";

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

    function "=" (X, Y: fraccion_t) return boolean is
    begin
        if X.denominador * Y.numerador = X.numerador * Y.denominador then
            return true;
        else
            return false;
        end if;
    end "=";

    function mcd (a, b: Integer) return Integer is
    begin
        if b = 0 then 
            return a;
        else
            return mcd(b, a mod b);
        end if;
    end mcd;

    function Simplificar (F: fraccion_t) return fraccion_t is
    result : fraccion_t;
    begin
        result.numerador := F.numerador / mcd(F.numerador, F.denominador);
        result.denominador := F.denominador / mcd(F.numerador, F.denominador);
        return result;
    end Simplificar;

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

    -- Procedures
    procedure Leer (F: out fraccion_t) is
    begin
        Es_int.Get(F.numerador);
        Es_int.Get(F.denominador);
    end Leer;

    procedure Escribir (F: fraccion_t) is
    begin
        --  Es_int.Put(F.numerador);
        Ada.Integer_Text_IO.Put(Item => Integer(F.numerador), Width => 2);
        Put(" /");
        Ada.Integer_Text_IO.Put(Item => Integer(F.denominador), Width => 2); New_Line;
        --  Es_int.Put(F.denominador); New_Line;
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