prompt ****************************************************************
prompt REPLICA MOMO_WALLET
prompt ****************************************************************
prompt Archivo....: momo_wallet_3102_01i.sql
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
PROMPT Creando la tabla &1 desde tabla externa
PROMPT ****************************************************************
--WHENEVER SQLERROR CONTINUE
ALTER SESSION SET NLS_NUMERIC_CHARACTERS='.,'
/
CREATE TABLE &1
(      
  id NUMBER(14),
  created_at VARCHAR2(50),
  agent_id NUMBER(14),
  updated_at VARCHAR2(50),
  comisiones NUMBER(20,3),
  billeteradeoperaciones NUMBER(20,3),
  giros NUMBER(20,3),
  saldodereserva NUMBER(20,3),
  billeteradedescarga NUMBER(20,1)
)  
ORGANIZATION EXTERNAL
(TYPE oracle_loader
 DEFAULT DIRECTORY &v_directory
 ACCESS PARAMETERS
 (      
  RECORDS DELIMITED BY newline
  BADFILE 'momo_wallet.bad'
  DISCARDFILE 'momo_wallet.dis'
  LOGFILE 'momo_wallet.log'
  FIELDS TERMINATED BY "|"  OPTIONALLY ENCLOSED BY '"'
  MISSING FIELD VALUES ARE NULL
 )
 LOCATION ('&2')
)
REJECT LIMIT UNLIMITED
/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/


