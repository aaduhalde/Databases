
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01a.sql 
prompt Autor......: Miguel Peralta
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Universo de transacciones IRIS
prompt 				
prompt *****************************************************************
prompt Historia del Proceso
prompt Fecha        Por           Descripcion
prompt **********   ***********   **************************************
prompt 22/06/2020   M. Peralta     Creacion del script
prompt *****************************************************************
prompt Seteos Iniciales
prompt *****************************************************************

@/racing/replica/seteos_iniciales.sql
select to_char(sysdate, 'yyyy-mm-dd hh24.mi.ss') "Tiempo Inicio" from dual
/
prompt ****************************************************************
prompt Lectura de tablas de parámetros
prompt ****************************************************************

col tbs_admin    		    new_value v_tbs_admin       noprint
col esquema_rac8        new_value v_esquema_rac8    noprint     

SELECT 
   pck_core.fc_get_parameter ('CORE', 'TBS_ADMIN')    tbs_admin,
   pck_core.fc_get_parameter('CORE','ESQUEMA_RAC8') esquema_rac8
FROM DUAL
/
COL esquema_iris new_value v_esquema_iris	noprint 
SELECT  par_value_varchar2 esquema_iris
FROM  param_actualiz_racing
WHERE par_procedure_name = 'CORE'
AND par_parameter_name = 'ESQUEMA_IRIS'
  /
COL fecha_proceso new_value v_fecha_proceso	noprint                                                     
SELECT par_value_date fecha_proceso
FROM PARAM_ACTUALIZ_RACING
WHERE par_procedure_name = 'EFECTIVIDAD_IRIS'
AND par_parameter_name = 'FECHA_PROCESO' 

/
PROMPT ****************************************************************
PROMPT Parámetros
PROMPT ****************************************************************
PROMPT Parámetro: [fecha_proceso]     - Valor: [&v_fecha_proceso]
PROMPT Parámetro: [esquema_rac8]      - Valor: [&v_esquema_rac8]
PROMPT Parámetro: [tbs_admin]         - Valor: [&v_tbs_admin]
PROMPT Parámetro: [esquema_iris]      - Valor: [&v_esquema_iris]
PROMPT ****************************************************************
PROMPT Actualizando datos en tabla 
PROMPT ****************************************************************
PROMPT Borrando datos de tabla 
PROMPT ****************************************************************
PROMPT ****************************************************************
PROMPT Creando Universo Inicial de Transacciones IRIS
PROMPT ****************************************************************

create TABLE AUX_G4389_IRIS_TRANSACCIONES
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
select 
  TR_DATE_TIME,    
  TR_DATE,         
  TR_HOUR,              
  IA_ID,            
  TR_ID ,              
  RET_MSISDN,           
  SUB_MSISDN,         
  OFR_ID,               
  OFR_NAME,             
  OFFER_TYPE,         
  SUB_BONUS,          
  RECHRGE_AMNT,         
  RET_COM,              
  RET_LOYALTY,         
  CAMP_NAME,            
  CHANNEL,            
  PRETUPS_IN_ID,        
  PRETUPS_OUT_ID,       
  PRETUPS_STATUS_CODE,  
  PRETUPS_STATUS_MSG,   
  PRETUPS_TIME_TAKN,    
  VAS_NODE,            
  VAS_IN_ID,          
  VAS_OUT_ID,          
  VAS_STATUS_CODE,   
  VAS_STATUS_MSG,    
  VAS_TIME_TAKN,      
  SMS_STATUS_CODE,     
  SMS_TIME_TAKN,   
  TRAN_STATUS,   
  GROUP_TYPE, 
  TRAN_TIME_TAKN, 
  E2E_TIME_TAKEN,
  TR_END_TIME,
  OFFERS_COUNT,
  DENM_AMNT,
  NODE 
  from &v_esquema_iris.IRISTRANSACTIONALDATA
where TR_DATE = '&v_fecha_proceso'
and pretups_status_code = '200'
/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/ 
