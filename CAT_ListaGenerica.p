/*-------------------------------------------------------------------- 
Archivo:    CAT_ListaGenerica.p
Propósito:  Listar los segmentos dados de alta para el Catalogo de segmentos

Modulo:     Configuracion del producto
Sintaxis:   ABL

Autor(es):      JGRC
Fec. Creado:    03/06/2021

Historia de modificaciones:
Razón de cada cambio: 
-----------------------------------------------------------------*/ 
                                                
DEFINE INPUT PARAMETER tabla AS CHAR FORMAT "x(50)".
DEFINE INPUT PARAMETER condicion AS CHAR FORMAT "x(50)".
DEFINE INPUT PARAMETER orden AS CHAR FORMAT "x(50)".
DEFINE INPUT PARAMETER campos AS CHAR FORMAT "x(50)".
DEFINE OUTPUT PARAMETER respuesta AS CHARACTER FORMAT "x(78)" NO-UNDO INIT "~{".

DEFINE VARIABLE qh AS WIDGET-HANDLE.
DEFINE VARIABLE hB AS HANDLE NO-UNDO.
DEFINE VARIABLE hF AS HANDLE NO-UNDO.
DEFINE VARIABLE hO AS HANDLE NO-UNDO.
    
CREATE QUERY qh.
CREATE BUFFER hB FOR TABLE "prueba".
ASSIGN hF = hB:BUFFER-FIELD("id")       
       hO = hB:BUFFER-FIELD("Campo1").
qh:SET-BUFFERS(hb).
qh:QUERY-PREPARE("FOR EACH " + tabla + " WHERE " + condicion + " BY " + orden).
qh:QUERY-OPEN.
     
REPEAT:
    qh:GET-NEXT().
    IF qh:QUERY-OFF-END THEN LEAVE.
        respuesta = respuesta + '"ID"' + ':"' + hF:BUFFER-VALUE + '",'.
        respuesta = respuesta + '"Campo1"' + ':"' + hO:BUFFER-VALUE + '",'.
END.
respuesta = respuesta + '}'.
qh:QUERY-CLOSE().
DELETE OBJECT qh.
