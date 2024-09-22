prompt ****************************************************************
prompt REPLICA MOMO_WALLET
prompt ****************************************************************
prompt Archivo....: momo_wallet_3102_01k.sql
prompt Autor......: Nuñez Nicolas
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Traslado de archivos
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
prompt Lectura de tablas de parametros
prompt ****************************************************************
col tbs_admin new_value v_tbs_admin noprint
col esquema_rac8 new_value v_esquema_rac8 noprint
col pais new_value v_pais noprint
COL fecha_proceso new_value v_fecha_proceso	noprint
SELECT pck_core.fc_get_parameter('CORE','TBS_ADMIN') tbs_admin,
       pck_core.fc_get_parameter('CORE','ESQUEMA_RAC8') esquema_rac8,
       pck_core.fc_get_parameter('CORE','PAIS') pais,
       TO_CHAR(SYSDATE,'DD/MM/YYYY') fecha_proceso
FROM   DUAL
/
PROMPT ****************************************************************
PROMPT Parametros
PROMPT ****************************************************************
PROMPT Parámetro: [ESQUEMA_RAC8]  - Valor: [&v_esquema_rac8]
PROMPT Parámetro: [PAIS]          - Valor: [&v_pais]
PROMPT Parámetro: [TABLESPACE]    - Valor: [&v_tbs_admin]
PROMPT Parámetro: [FECHA_PROCESO] - Valor: [&v_fecha_proceso]
PROMPT ****************************************************************
PROMPT Eliminando tables auxiliaries
PROMPT ****************************************************************
WHENEVER SQLERROR CONTINUE

DROP TABLE &1 PURGE
/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/
	