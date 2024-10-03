prompt ****************************************************************
prompt REPLICA MOMO_SCRATCHCARDS_HISTORY
prompt ****************************************************************
prompt Archivo....: momo_scratchcards_history_3440_01j.sql
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
col mail_control new_value v_mail_control	noprint
col directory new_value v_directory	noprint
col nombre_archivo new_value v_nombre_archivo noprint
col fecha_proceso new_value v_fecha_proceso	noprint
SELECT 'G3440' grupo,
       pck_core.fc_get_parameter('CORE','TBS_ADMIN') tbs_admin,
       pck_core.fc_get_parameter('CORE','ESQUEMA_RAC8') esquema_rac8,
       pck_core.fc_get_parameter('CORE','PAIS') pais,
       pck_core.fc_get_parameter('REPLICAS_MOMO','E_MAIL_CONTROL') mail_control,
       pck_core.fc_get_parameter('REPLICAS_MOMO','DIRECTORY') directory,
       '&2' nombre_archivo,
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
PROMPT Parametro: [ESQUEMA_RAC8]   - Valor: [&v_esquema_rac8]
PROMPT Parametro: [TABLESPACE]     - Valor: [&v_tbs_admin]
PROMPT Parametro: [PAIS]           - Valor: [&v_pais]
PROMPT Parametro: [E_MAIL_CONTROL] - Valor: [&v_mail_control]
PROMPT Parametro: [NOBRE_ARCHIVO]  - Valor: [&v_nombre_archivo]
PROMPT Parametro: [FECHA_PROCESO]  - Valor: [&v_fecha_proceso]
PROMPT Parametro: [PATH]           - Valor: [&v_path]
PROMPT ****************************************************************
PROMPT Insertando en tabla MOMO_SCRATCHCARDS_HISTORY
PROMPT ****************************************************************

DECLARE
   v_cantidad number;
   v_continua_secuencia varchar2(2);
   v_sqlcod varchar2(10):='';
   v_error_stack     varchar2(200);
   v_call_stack      varchar2(200);
   v_error_backtrace varchar2(200);
BEGIN   
	 SELECT par_value_varchar2                                     
	 INTO   v_continua_secuencia                                    
   FROM   Param_Actualiz_Racing                                    
   WHERE  par_procedure_name = 'MOMO_SCRATCHCARDS_HISTORY'                                    
   AND    par_parameter_name = 'CONTINUA_SECUENCIA';                                    
   
   IF v_continua_secuencia = 'SI' THEN
      INSERT INTO MOMO_SCRATCHCARDS_HISTORY
      (
				id,
			lot,
			"number",
			status_id,
			user_id,
			salesman_id,
			created_at,
			update_at,
			deposit,
			product_id,
			purchase_id,
			agent_id,
			created_at_date,
			invoice,
			expiration,
			imported,
			client_id,
			pda_id,
			iccid,
			sales_date,
			updated_at
      )
      SELECT id,
						lot,
						"number",
						status_id,
						user_id,
						salesman_id,
						TO_DATE(CREATED_AT,'YYYY-MM-DD HH24:MI:SS'), 
						update_at, 
						deposit,
						product_id,
						purchase_id,
						agent_id,
						TO_DATE(created_at_date,'YYYY-MM-DD HH24:MI:SS'),
						invoice,
						TO_DATE(expiration,'YYYY-MM-DD HH24:MI:SS'),
						imported,
						client_id,
						pda_id,
						iccid,
						TO_DATE(sales_date,'YYYY-MM-DD HH24:MI:SS'),
						TO_DATE(updated_at,'YYYY-MM-DD HH24:MI:SS')
      FROM &1;
      
      SELECT count(*)
      INTO v_cantidad
      FROM &1;
      
      dbms_output.put_line('****************************************************************');
      dbms_output.put_line(' Actualizacion diccionario de datos');
      dbms_output.put_line('****************************************************************');
            
      UPDATE Actualizacion_Racing
      SET    act_actualiz_date = SYSDATE
      WHERE  act_table_name = 'MOMO_SCRATCHCARDS_HISTORY';
      
      UPDATE PARAM_ACTUALIZ_RACING
      SET    par_value_date     = TRUNC(SYSDATE)
      WHERE  par_procedure_name = 'MOMO_SCRATCHCARDS_HISTORY'
        and  par_parameter_name = 'FECHA_PROCESO';
      
      UPDATE G3440_SCRATCHCARDS_HISTORY
      SET    ESTADO = 'EN PROCESO',
             FECHA_PROCESO = SYSDATE
      WHERE  ARCHIVO = '&3';
      
      COMMIT;
	    pck_catalogo.sp_insert_dw_monitor('&v_grupo', '&v_pais', 'MENSAJE', 'Archivo plano procesado: &v_nombre_archivo'); 
      pck_catalogo.sp_insert_dw_monitor('&v_grupo', '&v_pais', 'MENSAJE', 'Se Insertaron '||v_cantidad||' registros');     
   END IF;   

EXCEPTION
--WHEN NO_DATA_FOUND THEN
--  dbms_output.put_line('Se ejecuta cuando ocurre una excepcion de tipo NO_DATA_FOUND');
--WHEN ZERO_DIVIDE THEN
--  dbms_output.put_line('Se ejecuta cuando ocurre una excepcion de tipo ZERO_DIVIDE');
WHEN DUP_VAL_ON_INDEX THEN
	 ROLLBACK; 	 
   pck_catalogo.sp_insert_dw_monitor('&v_grupo', '&v_pais', 'MENSAJE', 'Archivo plano procesado: &v_nombre_archivo'); 
   pck_catalogo.sp_insert_dw_monitor('&v_grupo', '&v_pais', 'ORA-00001', 'Se intento insertar un ID ya existente');                                                                              
WHEN OTHERS THEN
   v_sqlcod := 'ORA'||SQLCODE;
   IF v_sqlcod = 'ORA-29913' THEN   
      pck_catalogo.sp_insert_dw_monitor('&v_grupo', '&v_pais', 'ORA-29913', 'Controlar el contenido y/o los permisos del archivo plano &v_nombre_archivo');     
   ELSE
      pck_catalogo.sp_insert_dw_monitor('&v_grupo', '&v_pais', 'MENSAJE', 'Archivo plano procesado: &v_nombre_archivo'); 
      v_error_stack     := DBMS_UTILITY.format_error_stack();
      v_call_stack      := DBMS_UTILITY.format_call_stack();
      v_error_backtrace := DBMS_UTILITY.format_error_backtrace();
   
      pck_catalogo.sp_insert_dw_monitor('&v_grupo', '&v_pais', v_sqlcod, 'ERROR_STACK: '||v_error_stack); 
      pck_catalogo.sp_insert_dw_monitor('&v_grupo', '&v_pais', v_sqlcod, 'CALL_STACK: '||v_call_stack);  
      pck_catalogo.sp_insert_dw_monitor('&v_grupo', '&v_pais', v_sqlcod, 'ERROR_BACKTRACE: '||v_error_backtrace);                                                                                 
   END IF;
END;    
/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/
