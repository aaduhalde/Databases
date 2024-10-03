prompt ****************************************************************
prompt REPLICA MOMO_WALLET
prompt ****************************************************************
prompt Archivo....: momo_wallet_3102_05a.sql
prompt Autor......: Nuñez Nicolas
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Borrado de tablas auxiliares
prompt *****************************************************************
prompt Historia del Proceso
prompt Fecha        Por           Descripcion
prompt **********   ***********   **************************************
prompt 17/01/2017   N. Nuñez     Creacion del script
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

DROP TABLE AUX_3102_NUEVOS PURGE
/
DROP TABLE AUX_3102_SECUENCIA_EJECUCION PURGE
/
DROP TABLE AUX_3102_SECUENCIA_EJECUCION_2 PURGE
/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/
