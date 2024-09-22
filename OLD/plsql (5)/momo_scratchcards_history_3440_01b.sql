prompt ****************************************************************
prompt REPLICA MOMO_SCRATCHCARDS_HISTORY
prompt ****************************************************************
prompt Archivo....: momo_scratchcards_history_3440_01b.sql
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
col directory new_value v_directory	noprint
col fecha_proceso new_value v_fecha_proceso	noprint
SELECT pck_core.fc_get_parameter('CORE','TBS_ADMIN') tbs_admin,
       pck_core.fc_get_parameter('CORE','ESQUEMA_RAC8') esquema_rac8,
       pck_core.fc_get_parameter('CORE','PAIS') pais,
       pck_core.fc_get_parameter('REPLICAS_MOMO','DIRECTORY') directory,
       TO_CHAR(SYSDATE,'DD/MM/YYYY') fecha_proceso
FROM   DUAL
/
COL path new_value v_path	noprint
SELECT DIRECTORY_PATH path
FROM   dba_directories
WHERE  directory_name = '&v_directory'
/
PROMPT ****************************************************************
PROMPT Parametros
PROMPT ****************************************************************
PROMPT Parametro: [ESQUEMA_RAC8]  - Valor: [&v_esquema_rac8]
PROMPT Parametro: [PAIS]          - Valor: [&v_pais]
PROMPT Parametro: [FECHA_PROCESO] - Valor: [&v_fecha_proceso]
PROMPT Parametro: [DIRECTORY]     - Valor: [&v_directory]
PROMPT Parametro: [PATH]          - Valor: [&v_path]
PROMPT ****************************************************************
PROMPT Creando la tabla AUX_3440_NUEVOS desde tabla externa
PROMPT ****************************************************************
WHENEVER SQLERROR CONTINUE
ALTER SESSION SET NLS_NUMERIC_CHARACTERS=',.'
/

CREATE TABLE AUX_3440_NUEVOS
(      
	ARCHIVO VARCHAR2(200)
)  
ORGANIZATION EXTERNAL
(TYPE oracle_loader
 DEFAULT DIRECTORY &v_directory
 ACCESS PARAMETERS
 (      
  RECORDS DELIMITED BY newline
  BADFILE 'nuevos_momo_scratchcards_history.bad'
  DISCARDFILE 'nuevos_momo_scratchcards_history.dis'
  LOGFILE 'nuevos_momo_scratchcards_history.log'
  FIELDS TERMINATED BY " "  OPTIONALLY ENCLOSED BY '"'
  MISSING FIELD VALUES ARE NULL
 )
 LOCATION ('nuevos_momo_scratchcards_history.dat')
)
REJECT LIMIT UNLIMITED
/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/
