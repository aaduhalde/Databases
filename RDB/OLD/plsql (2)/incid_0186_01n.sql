PROMPT ****************************************************************
PROMPT * * * * * * * * P R O C E S S	M O N I T O R * * * * * * * * *
PROMPT ****************************************************************
PROMPT Archivo....: incid01n.sql
PROMPT Autor......: Fernando Tarasconi
PROMPT Reviso.....:
PROMPT Produccion.:
PROMPT
PROMPT Descripcion:
PROMPT
PROMPT Nota:
PROMPT
PROMPT
PROMPT ****************************************************************
PROMPT Historia del Proceso
PROMPT
PROMPT Fecha		Por			Descripcion
PROMPT ********** *******		*****************************************
PROMPT 23/02/2004 F.Tarasconi Creacion del script
PROMPT
PROMPT ****************************************************************
PROMPT Seteos Iniciales
PROMPT ****************************************************************
SET timing on
SET serveroutput on size 10000
WHENEVER sqlerror exit rollback
ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy'
/
SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo
  FROM DUAL
/
PROMPT ****************************************************************
PROMPT Leyendo parametros
PROMPT ****************************************************************

col val1 new_value esquema
COL val2 new_value  yyyymm noprint
select  pck_core.fc_get_parameter('CORE','ESQUEMA_RAC8') val1 from dual
/
SELECT TO_CHAR (NVL(par.par_value_date, SYSDATE), 'yyyymm') val2
FROM   param_actualiz_racing par
 WHERE par.par_procedure_name = 'INC_ID_CEL'
   AND par.par_parameter_name = 'FECHA_PROCESO'
/

PROMPT ****************************************************************
PROMPT Parametros Leidos
PROMPT Esquema - [&esquema]
PROMPT ****************************************************************

PROMPT ****************************************************************
PROMPT Actualizando Tabla: trunca particion incidcel_&yyyymm inc_id_cel
PROMPT ****************************************************************
--ALTER TABLE &&esquema.inc_id_cel TRUNCATE PARTITION incidcel_&yyyymm
--ALTER TABLE inc_id_cel TRUNCATE PARTITION incidcel_&yyyymm
/
PROMPT
PROMPT ****************************************************************
PROMPT Insertando en  Tabla INC_ID_CEL particion incidcel_&yyyymm inc_id_cel
PROMPT ****************************************************************
--ALTER TABLE &&esquema.inc_id_cel EXCHANGE PARTITION incidcel_&yyyymm
--ALTER TABLE inc_id_cel EXCHANGE PARTITION incidcel_&yyyymm WITH TABLE aux_inc_id_cel 

INSERT /*+ APPEND parallel(a,4) */ INTO INC_ID_CEL a
(
  DOD_SCH_ID              
 ,SCH_END_DATE            
 ,CELLULAR_NUMBER         
 ,COLLECTION_ENTITY_TYPE  
 ,INC_GLA_ID              
 ,DOD_AMOUNT              
 ,DOD_AMOUNT_TOT          
 ,DOD_AMOUNT_VAT          
 ,DOD_QUANTITY            
 ,ACCOUNT_ID              
 ,DEALER_ID               
 ,RATE_PLAN_ID            
 ,ACTIVATION_DATE         
 ,SERVICE_STATUS          
 ,MARKET_CODE             
 ,COMPANY_ID              
 ,CLIENT_CLASS            
 ,CREDIT_LIMIT_CELLULAR   
 ,DOD_INC_ID              
 ,CBT_ID                  
 ,PRO_MODE_TYPE           
)
SELECT    /*+ PARALLEL(c,4) */
  DOD_SCH_ID       
 ,SCH_END_DATE            
 ,CELLULAR_NUMBER         
 ,COLLECTION_ENTITY_TYPE  
 ,INC_GLA_ID              
 ,DOD_AMOUNT              
 ,DOD_AMOUNT_TOT          
 ,DOD_AMOUNT_VAT          
 ,DOD_QUANTITY            
 ,ACCOUNT_ID              
 ,DEALER_ID               
 ,RATE_PLAN_ID            
 ,ACTIVATION_DATE         
 ,SERVICE_STATUS          
 ,MARKET_CODE             
 ,COMPANY_ID              
 ,CLIENT_CLASS            
 ,CREDIT_LIMIT_CELLULAR   
 ,DOD_INC_ID              
 ,CBT_ID                  
 ,PRO_MODE_TYPE           
FROM aux_inc_id_cel c 
/

COMMIT
/

SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo
  FROM DUAL
/
