prompt ****************************************************************
prompt REPLICA MOMO_WALLET
prompt ****************************************************************
prompt Archivo....: momo_wallet_3102_01d.sql
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
col fecha_proceso new_value v_fecha_proceso	noprint
col directory new_value v_directory	noprint
col path_script new_value v_path_script	noprint
SELECT pck_core.fc_get_parameter('CORE','TBS_ADMIN') tbs_admin,
       pck_core.fc_get_parameter('CORE','ESQUEMA_RAC8') esquema_rac8,
       pck_core.fc_get_parameter('CORE','PAIS') pais,
       pck_core.fc_get_parameter('REPLICAS_MOMO','DIRECTORY') directory,
       pck_core.fc_get_parameter('MOMO_WALLET','PATH_SCRIPT') path_script,
       TO_CHAR(SYSDATE,'DD/MM/YYYY') fecha_proceso
FROM   DUAL
/
col path new_value v_path	noprint
SELECT DIRECTORY_PATH path
FROM   dba_directories
WHERE  directory_name = '&v_directory'
/
PROMPT ****************************************************************
PROMPT Parametros
PROMPT ****************************************************************
PROMPT Parametro: [ESQUEMA_RAC8]  - Valor: [&v_esquema_rac8]
PROMPT Parametro: [PAIS]          - Valor: [&v_pais]
PROMPT Parametro: [TABLESPACE]    - Valor: [&v_tbs_admin]
PROMPT Parametro: [FECHA_PROCESO] - Valor: [&v_fecha_proceso]
PROMPT Parametro: [DIRECTORY]     - Valor: [&v_directory]
PROMPT Parametro: [PATH]          - Valor: [&v_path]
PROMPT Parametro: [PATH_SCRIPT]   - Valor: [&v_path_script]
PROMPT ****************************************************************
PROMPT Armando secuencia de ejecucion
PROMPT ****************************************************************

CREATE TABLE AUX_3102_SECUENCIA_EJECUCION
TABLESPACE &v_tbs_admin PARALLEL 4 AS
SELECT ARCHIVO, 
       'start '||'&v_path_script'||'momo_wallet_3102_01h.sql'|| 
       ' '||TRIM(ARCHIVO) AS SCRIPT_SQL                                  --VALOR DEL CAMPO ARCHIVO
FROM   G3102_WALLET
WHERE  ESTADO = 'SIN PROCESAR'
UNION
SELECT ARCHIVO, 
       'start '||'&v_path_script'||'momo_wallet_3102_01i.sql'||    
       ' AUX_3102_'||TRIM(SUBSTR(ARCHIVO,LENGTH('&v_path')+6,18))||     --NOMBRE DE LA TABLA AUXILIAR
       ' '|| TRIM(SUBSTR(ARCHIVO,LENGTH('&v_path')+1,36)) AS SCRIPT_SQL  --NOMBRE ARCHIVO PLANO
FROM   G3102_WALLET
WHERE  ESTADO = 'SIN PROCESAR'
UNION 
SELECT ARCHIVO, 
       'start '||'&v_path_script'||'momo_wallet_3102_01j.sql'||  
       ' AUX_3102_'||TRIM(SUBSTR(ARCHIVO,LENGTH('&v_path')+6,18))||     --NOMBRE DE LA TABLA AUXILIAR 
       ' '|| TRIM(SUBSTR(ARCHIVO,LENGTH('&v_path')+1,36))||              --NOMBRE ARCHIVO PLANO
       ' '||TRIM(ARCHIVO) AS SCRIPT_SQL                                  --VALOR DEL CAMPO ARCHIVO
FROM   G3102_WALLET
WHERE  ESTADO = 'SIN PROCESAR'
/
	 
set heading off
set linesize 500
set timing off
spoo &v_path_script.momo_wallet_3102_01e.sql

SELECT SCRIPT_SQL  
FROM   AUX_3102_SECUENCIA_EJECUCION 
ORDER BY ARCHIVO, SCRIPT_SQL
/
	 
spoo OFF
! chmod 755 &v_path_script.momo_wallet_3102_01e.sql
/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/
