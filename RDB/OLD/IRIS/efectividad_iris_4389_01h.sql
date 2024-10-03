
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01h.sql 
prompt Autor......: Miguel Peralta
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Unimos las ofertas
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
PROMPT Unimos las ofertas
PROMPT ****************************************************************

create TABLE AUX_G4389_IRIS_6
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
SELECT 
  I4.ID_TRANSACCION,
  I4.FECHA_HORA_RECARGA,
  I4.FECHA_RECARGA,
  I4.CELLULAR_NUMBER_CLI,
  I4.RET_MSISDN,
  I4.ID_OFERTA_COMPRADA,
  I4.NOMBRE_OFERTA_COMPRADA,
  I4.TIPO_OFERTA_COMPRADA,
  I4.NOMBRE_CAMPANA_COMPRADA,
  I4.CANAL,
  I4.MONTO_ORIGINAL_CLI,
  I4.MONTO_RECARGA_CLI,
  I4.MONTO_ADICIONAL_CLI,
  I4.CANTIDAD_TRANSACCINES,
  I4.MONTO_EXTRA_UP,
  I4.MONTO_EXTRA_RECO_RECARGA ,
  I4.OFERTAS_RECOMENDADAS,
  I4.ID_OFERTA_RECOMENDADA,
  I4.NOMBRE_OFERTA_RECOMENDADA,
  I4.NOMBRE_CAMPANA_RECOMENDADA     
FROM AUX_G4389_IRIS_4 I4
UNION
SELECT 
  I5.ID_TRANSACCION,
  I5.FECHA_HORA_RECARGA,
  I5.FECHA_RECARGA,
  I5.CELLULAR_NUMBER_CLI,
  I5.RET_MSISDN,
  I5.ID_OFERTA_COMPRADA,
  I5.NOMBRE_OFERTA_COMPRADA,
  I5.TIPO_OFERTA_COMPRADA,
  I5.NOMBRE_CAMPANA_COMPRADA,
  I5.CANAL,
  I5.MONTO_ORIGINAL_CLI,
  I5.MONTO_RECARGA_CLI,
  I5.MONTO_ADICIONAL_CLI,
  I5.CANTIDAD_TRANSACCINES,
  I5.MONTO_EXTRA_UP,
  I5.MONTO_EXTRA_RECO_RECARGA ,
  I5.OFERTAS_RECOMENDADAS,
  I5.ID_OFERTA_RECOMENDADA,
  I5.NOMBRE_OFERTA_RECOMENDADA,
  I5.NOMBRE_CAMPANA_RECOMENDADA   
FROM AUX_G4389_IRIS_5 I5

/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/ 
