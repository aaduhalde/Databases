prompt ****************************************************************
prompt REPLICA MOMO_SCRATCHCARDS_HISTORY
prompt ****************************************************************
prompt Archivo....: momo_scratchcards_history_3440_01h.sql
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
col grupo new_value v_grupo	noprint
col tbs_admin new_value v_tbs_admin noprint
col esquema_rac8 new_value v_esquema_rac8 noprint
col pais new_value v_pais noprint
col mail_control new_value v_mail_control	noprint
col directory new_value v_directory	noprint
col fecha_proceso new_value v_fecha_proceso	noprint
SELECT 'G3440' grupo,
       pck_core.fc_get_parameter('CORE','TBS_ADMIN') tbs_admin,
       pck_core.fc_get_parameter('CORE','ESQUEMA_RAC8') esquema_rac8,
       pck_core.fc_get_parameter('CORE','PAIS') pais,
       pck_core.fc_get_parameter('REPLICAS_MOMO','E_MAIL_CONTROL') mail_control,
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
PROMPT Parametro: [ESQUEMA_RAC8]   - Valor: [&v_esquema_rac8]
PROMPT Parametro: [TABLESPACE]     - Valor: [&v_tbs_admin]
PROMPT Parametro: [PAIS]           - Valor: [&v_pais]
PROMPT Parametro: [E_MAIL_CONTROL] - Valor: [&v_mail_control]
PROMPT Parametro: [FECHA_PROCESO]  - Valor: [&v_fecha_proceso]
PROMPT Parametro: [PATH]           - Valor: [&v_path]
PROMPT ****************************************************************
PROMPT Control de secuencia de carga tabla MOMO_SCRATCHCARDS_HISTORY
PROMPT ****************************************************************

DECLARE
   v_nombre_archivo varchar2(200);
   v_procesado_ok varchar2(11);
   v_sin_procesar varchar2(11); 
   v_diferencia number;
   v_archivo_siguiente varchar2(200);
      
BEGIN
	 SELECT TRIM(SUBSTR(min(ARCHIVO),LENGTH('&v_path')+27,11)),
	        TRIM(SUBSTR(min(ARCHIVO),LENGTH('&v_path')+1,43))  
   INTO   v_sin_procesar, v_nombre_archivo
   FROM   G3440_SCRATCHCARDS_HISTORY
   WHERE  ARCHIVO = '&1';

   SELECT TRIM(SUBSTR(max(ARCHIVO),LENGTH('&v_path')+27,11))
   INTO   v_procesado_ok
   FROM   G3440_SCRATCHCARDS_HISTORY
   WHERE  ESTADO IN ('PROCESADO OK','EN PROCESO');

   SELECT (TO_DATE((SELECT TRIM(SUBSTR(MIN(ARCHIVO),LENGTH('&v_path')+27,11)) 
                    FROM G3440_SCRATCHCARDS_HISTORY WHERE  ARCHIVO = '&1'),'YYYYMMDD_HH24') - 
           TO_DATE((SELECT TRIM(SUBSTR(MAX(ARCHIVO),LENGTH('&v_path')+27,11)) 
                    FROM G3440_SCRATCHCARDS_HISTORY WHERE  ESTADO IN ('PROCESADO OK','EN PROCESO')),'YYYYMMDD_HH24')) * 24,
           'momo_scratchcards_history_'||TO_CHAR(TO_DATE((SELECT TRIM(SUBSTR(MAX(ARCHIVO),LENGTH('&v_path')+27,11)) 
                                                     FROM G3440_SCRATCHCARDS_HISTORY 
                                                     WHERE  ESTADO IN ('PROCESADO OK','EN PROCESO')),'YYYYMMDD_HH24') + (1/24), 'YYYYMMDD_HH24')||'.csv'
   INTO v_diferencia, v_archivo_siguiente
   FROM DUAL;

   IF v_diferencia = 1 OR v_procesado_ok IS NULL THEN
      UPDATE param_actualiz_racing
      SET    par_value_varchar2 = 'SI'
      WHERE par_procedure_name = 'MOMO_SCRATCHCARDS_HISTORY'
        AND par_parameter_name = 'CONTINUA_SECUENCIA';
      COMMIT;
   ELSE
      UPDATE param_actualiz_racing
      SET    par_value_varchar2 = 'NO'
      WHERE par_procedure_name = 'MOMO_SCRATCHCARDS_HISTORY'
        AND par_parameter_name = 'CONTINUA_SECUENCIA';
      COMMIT;
      pck_catalogo.sp_insert_dw_monitor('&v_grupo', '&v_pais', 'PRO-00003', 'El archivo: '||v_archivo_siguiente||' debe ser el siguiente de la secuencia');
   END IF;
EXCEPTION
--WHEN NO_DATA_FOUND THEN
--  dbms_output.put_line('Se ejecuta cuando ocurre una excepcion de tipo NO_DATA_FOUND');
--WHEN ZERO_DIVIDE THEN
--  dbms_output.put_line('Se ejecuta cuando ocurre una excepcion de tipo ZERO_DIVIDE');
WHEN OTHERS THEN
   pck_catalogo.sp_insert_dw_monitor('&v_grupo', '&v_pais', 'PRO-00004', 'Solicitar archivo con formato de nombre correcto al proveedor de dato - nombre actual: '||v_nombre_archivo);     
   UPDATE param_actualiz_racing
   SET    par_value_varchar2 = 'NO'
   WHERE par_procedure_name = 'MOMO_SCRATCHCARDS_HISTORY'
     AND par_parameter_name = 'CONTINUA_SECUENCIA';
   COMMIT; 
END;    
/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/
