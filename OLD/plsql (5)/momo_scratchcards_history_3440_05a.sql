prompt ****************************************************************
prompt REPLICA MOMO_SCRATCHCARDS_HISTORY
prompt ****************************************************************
prompt Archivo....: momo_scratchcards_history_3440_05a.sql
prompt Autor......: Nu�ez Nicolas
prompt Reviso.....:
prompt Produccion.:
prompt Descripci�n: Borrado de tablas auxiliares
prompt *****************************************************************
prompt Historia del Proceso
prompt Fecha        Por           Descripcion
prompt **********   ***********   **************************************
prompt 26/01/2017   N. Nu�ez     Creacion del script
prompt *****************************************************************
prompt Seteos Iniciales
prompt *****************************************************************

@/racing/replica/seteos_iniciales.sql
select to_char(sysdate, 'yyyy-mm-dd hh24.mi.ss') "Tiempo Inicio" from dual
/
prompt ****************************************************************
prompt Eliminando tables auxiliaries
prompt ****************************************************************
WHENEVER SQLERROR CONTINUE

DROP TABLE AUX_3440_NUEVOS PURGE
/
DROP TABLE AUX_3440_SECUENCIA_EJECUCION PURGE
/
DROP TABLE AUX_3440_SECUENCIA_EJECUCION_2 PURGE
/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/
