DEFINE VARIABLE respuesta AS CHAR FORMAT "X(80)".
RUN CAT_ListaGenerica.P (INPUT "segmento", INPUT "ID > 0", INPUT "segmento DESC", INPUT "", OUTPUT respuesta).
DISPLAY respuesta WITH FRAME A WIDTH 200.
