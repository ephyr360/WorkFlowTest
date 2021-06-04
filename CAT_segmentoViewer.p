/*-------------------------------------------------------------------- 
Archivo:    CAT_segmentoViewer.p
Proposito:  Datos de detalle del segmento

Modulo:     Configuracion del producto
Sintaxis:   ABL

Autor(es):      JGRC
Fec. Creado:    03/06/2021

Historia de modificaciones:
Razón de cada cambio: 
-----------------------------------------------------------------*/ 

{GEN_JsonStart.i}

DEFINE INPUT PARAMETER idSegmento AS CHARACTER FORMAT "X(10)".
DEFINE OUTPUT PARAMETER respuesta AS CHARACTER FORMAT "X(200)".

DEFINE TEMP-TABLE ttTest
    FIELD f1Segmento AS CHARACTER FORMAT "x(8)"
    FIELD f2Descr_segmento AS CHARACTER FORMAT "x(60)"
    FIELD f3Segm_default AS LOGICAL INIT FALSE
    FIELD f4Default_reserva AS LOGICAL INIT FALSE
    FIELD f5Tipo AS INTEGER INIT 1
    FIELD f6Estatus AS INTEGER INIT 0. 

FIND FIRST segmento WHERE segmento.segmento = idSegmento NO-LOCK NO-ERROR.
IF AVAILABLE segmento THEN
DO:
        
    CREATE ttTest.
    ASSIGN 
        f1Segmento = segmento.segmento
        f2Descr_segmento = segmento.descr_segmento
        f3Segm_default = segmento.segm_default
        f4Default_reserva = segmento.default_reserva
        f5Tipo = segmento.tipo
        f6Estatus = segmento.estatus.

    htt = TEMP-TABLE ttTest:HANDLE.

    jArr = NEW JsonArray().
    jObj = NEW JsonObject().

    htt:WRITE-JSON("JsonArray", jArr).

    htt:WRITE-JSON("JsonObject", jObj).

    respuesta = STRING(jObj:GetJsonText()).

    OUTPUT CLOSE.        
END.
ELSE DO:
    respuesta = "~{}".
END.
