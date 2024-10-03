prompt ****************************************************************
prompt REPLICA MOMO_WALLET
prompt ****************************************************************
prompt Archivo....: momo_wallet_3102_01c.sql
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
COL mail_control new_value v_mail_control	noprint
COL directory new_value v_directory	noprint
col fecha_proceso new_value v_fecha_proceso	noprint
SELECT pck_core.fc_get_parameter('CORE','TBS_ADMIN') tbs_admin,
       pck_core.fc_get_parameter('CORE','ESQUEMA_RAC8') esquema_rac8,
       pck_core.fc_get_parameter('CORE','PAIS') pais,
       pck_core.fc_get_parameter('REPLICAS_MOMO','E_MAIL_CONTROL') mail_control,
       pck_core.fc_get_parameter('REPLICAS_MOMO','DIRECTORY') directory,
       TO_CHAR(SYSDATE,'DD/MM/YYYY') fecha_proceso
FROM   DUAL
/
PROMPT ****************************************************************
PROMPT Parametros
PROMPT ****************************************************************
PROMPT Parametro: [ESQUEMA_RAC8]   - Valor: [&v_esquema_rac8]
PROMPT Parametro: [TABLESPACE]     - Valor: [&v_tbs_admin]
PROMPT Parametro: [PAIS]           - Valor: [&v_pais]
PROMPT Parametro: [FECHA_PROCESO]  - Valor: [&v_fecha_proceso]
PROMPT ****************************************************************
PROMPT Insertando en tabla G3102_WALLET
PROMPT ****************************************************************

INSERT /*+ append parallel(a,4) */ INTO G3102_WALLET a
(  
   ARCHIVO,
   ESTADO, 
   FECHA_PROCESO
)
SELECT /*+ parallel(n,4) */
       TRIM(ARCHIVO), 
       'SIN PROCESAR', 
       SYSDATE
FROM   AUX_3102_NUEVOS n
WHERE  NOT EXISTS(SELECT * FROM G3102_WALLET p
                  WHERE  UPPER(TRIM(N.ARCHIVO)) = UPPER(TRIM(P.ARCHIVO)))
/
COMMIT 
/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/
