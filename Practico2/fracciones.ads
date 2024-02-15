package fracciones is 
    type fraccion_t is private;

function "+" (X,Y: fraccion_t) return fraccion_t;
function "-" (X: fraccion_t) return fraccion_t;
function "-" (X,Y: fraccion_t) return fraccion_t;
function "*" (X,Y: fraccion_t) return fraccion_t;
function "/" (X,Y: fraccion_t) return fraccion_t;
function "=" (X,Y: fraccion_t) return Boolean;

---- Operaciones de  entrada/salida con la consola
procedure Leer (F: out fraccion_t);
procedure Escribir (F: in fraccion_t);

---- Constructor de numeros fraccionarios a partir de números enteros
function "/" (X, Y: Integer) return fraccion_t;

---- Operaciones para  obtener las partes de una fracción
function Numerador (F: fraccion_t) return Integer;
function Denominador (F: fraccion_t) return Positive;

private 
    type fraccion_t is record
        numerador: Integer;
        denominador: Positive;
    end record;

function Simplificar (F: fraccion_t) return fraccion_t;
function mcd(a, b: Integer) return Integer;
--  function inverso(X: fraccion_t) return fraccion_t;

end fracciones;

