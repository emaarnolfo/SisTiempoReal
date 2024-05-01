-- Paquete donde se definen los tipos y procedimientos necesarios para la planificación de las tareas
package Plan is 

    type ref_Procedimiento_t        is access   procedure;
    type array_ref_Procedimiento_t  is array    (Positive range <>) of ref_Procedimiento_t;
    type array_Tiempos_t            is array    (Positive range <>) of Natural;

    type reg_Planificacion_t        is record
        Nombre  :   Positive;   -- Número de la tarea
        T       :   Natural;    -- Período
        D       :   Natural;    -- Plazo
        C       :   Natural;    -- Tiempo de cómputo
        P       :   Positive;   -- Prioridad
        R       :   Natural;    -- Tiempo de respuesta
        Planif  :   Boolean; -- Indica si la tarea es planificable
    end record;

    type array_reg_Planificacion_t  is array    (Positive range <>) of reg_Planificacion_t;

    procedure Medir (Procedimientos: array_ref_Procedimiento_T; Tiempos : out array_Tiempos_t);
    procedure Medir (Procedimientos: array_ref_Procedimiento_T; Tareas: in out array_reg_Planificacion_t);
    procedure Planificar (Tareas: in out array_reg_Planificacion_t);

end Plan;