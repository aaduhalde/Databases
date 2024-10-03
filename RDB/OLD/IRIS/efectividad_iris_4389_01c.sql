
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01c.sql 
prompt Autor......: Miguel Peralta
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Unimos las recargas realizadas con las ofertas recomendadas de IRIS
prompt 				
prompt *****************************************************************
prompt Historia del Proceso
prompt Fecha        Por           Descripcion
prompt **********   ***********   **************************************
prompt 24/06/2020   M. Peralta     Creacion del script
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
PROMPT Unimos las ofertas con las recargas de IRIS
PROMPT ****************************************************************

create TABLE AUX_G4389_IRIS_1
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
SELECT 
     ITX.TR_ID ID_TRANSACCION,
     ITX.TR_DATE_TIME FECHA_HORA_RECARGA,
     ITX.TR_DATE 	FECHA_RECARGA,
     ITX.SUB_MSISDN CELLULAR_NUMBER_CLI,
     ITX.RET_MSISDN,
     ITX.OFR_ID ID_OFERTA_COMPRADA,
     ITX.OFR_NAME NOMBRE_OFERTA_COMPRADA, 
     ITX.OFFER_TYPE TIPO_OFERTA_COMPRADA, 
     ITX.CAMP_NAME NOMBRE_CAMPANA_COMPRADA,
     ITX.CHANNEL CANAL,
     ITX.DENM_AMNT MONTO_ORIGINAL_CLI,
     ITX.RECHRGE_AMNT MONTO_RECARGA_CLI,
     ITX.SUB_BONUS MONTO_ADICIONAL_CLI,
     COUNT(DISTINCT ITX.TR_ID) CANTIDAD_TRANSACCINES,
     SUM((CASE WHEN ITX.OFFER_TYPE = 2 THEN (ITX.RECHRGE_AMNT-ITX.DENM_AMNT) ELSE 0 END))MONTO_EXTRA_UP,
     SUM((CASE WHEN ITX.OFFER_TYPE = 3 THEN (ITX.RECHRGE_AMNT-ITX.DENM_AMNT) ELSE 0 END))MONTO_EXTRA_RECO_RECARGA,
     IOFD.ELIGIBLE_OFFERS OFERTAS_RECOMENDADAS
  FROM AUX_G4389_IRIS_TRANSACCIONES ITX
  	JOIN AUX_G4389_IRIS_OFERTAS IOFD
  		ON (TRIM(IOFD.TR_ID) = TRIM(ITX.TR_ID))
WHERE ITX.TR_DATE = '&v_fecha_proceso'
GROUP BY 
     ITX.TR_ID ,
     ITX.TR_DATE_TIME ,
     ITX.TR_DATE 	,
     ITX.SUB_MSISDN ,
     ITX.RET_MSISDN,
     ITX.OFR_ID ,
     ITX.OFR_NAME , 
     ITX.OFFER_TYPE , 
     ITX.CAMP_NAME ,
     ITX.CHANNEL ,
     ITX.DENM_AMNT,
     ITX.RECHRGE_AMNT,
     ITX.SUB_BONUS,
     IOFD.ELIGIBLE_OFFERS

/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/ 
