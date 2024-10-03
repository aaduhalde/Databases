prompt ****************************************************************
prompt REPLICA MOMO_LOCATE_HISTORY
prompt ****************************************************************
prompt Archivo....: momo_wallet_3102_01l.sql
prompt Autor......: Nu�ez Nicolas
prompt Reviso.....:
prompt Produccion.:
prompt Descripci�n: Traslado de archivos
prompt *****************************************************************
prompt Historia del Proceso
prompt Fecha        Por           Descripcion
prompt **********   ***********   **************************************
prompt 17/01/2017   N. Nu�ez     Creacion del script
prompt *****************************************************************
prompt Seteos Iniciales
prompt *****************************************************************

@/racing/replica/seteos_iniciales.sql
select to_char(sysdate, 'yyyy-mm-dd hh24.mi.ss') "Tiempo Inicio" from dual
/
prompt ****************************************************************
prompt Lectura de tablas de parametros
prompt ****************************************************************
col grupo new_value v_grupo	noprint
col tbs_admin new_value v_tbs_admin noprint
col esquema_rac8 new_value v_esquema_rac8 noprint
col pais new_value v_pais noprint
col directory new_value v_directory	noprint
col fecha_proceso new_value v_fecha_proceso	noprint
col archivo_borrar new_value v_archivo_borrar	noprint
SELECT 'G3102' grupo,
       pck_core.fc_get_parameter('CORE','TBS_ADMIN') tbs_admin,
       pck_core.fc_get_parameter('CORE','ESQUEMA_RAC8') esquema_rac8,
       pck_core.fc_get_parameter('CORE','PAIS') pais,       
       pck_core.fc_get_parameter('REPLICAS_MOMO','DIRECTORY') directory,
       TO_CHAR(SYSDATE,'DD/MM/YYYY') fecha_proceso,
       'momo_wallet_'||TO_CHAR(SYSDATE-40, 'YYYYMMDD')||'_*.procesado' archivo_borrar
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
PROMPT Par�metro: [ESQUEMA_RAC8]  - Valor: [&v_esquema_rac8]
PROMPT Par�metro: [PAIS]          - Valor: [&v_pais]
PROMPT Par�metro: [TABLESPACE]    - Valor: [&v_tbs_admin]
PROMPT Par�metro: [FECHA_PROCESO] - Valor: [&v_fecha_proceso]
PROMPT ****************************************************************
PROMPT Actualizando tabla de Estados
PROMPT ****************************************************************

UPDATE G3102_WALLET
SET    ESTADO = 'PROCESADO OK',
       FECHA_PROCESO = SYSDATE
WHERE  ARCHIVO = '&1'
/   
COMMIT
/
PROMPT ****************************************************************
PROMPT Renombrado de archivo: 
PROMPT mv &1 &2
PROMPT ****************************************************************
PROMPT Borrado de archivo: 
PROMPT rm &v_archivo_borrar
PROMPT ****************************************************************
	! mv &1 &2
  ! rm &v_path.&v_archivo_borrar
  ! rm &v_path.momo_wallet.dis
	! rm &v_path.momo_wallet.bad

SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/
	