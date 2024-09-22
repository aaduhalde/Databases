
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01n.sql 
prompt Autor......: Miguel Peralta
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Obtenemos el HANDLE del cliente
prompt 				
prompt *****************************************************************
prompt Historia del Proceso
prompt Fecha        Por           Descripcion
prompt **********   ***********   **************************************
prompt 25/06/2020   M. Peralta     Creacion del script
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
PROMPT Obtenemos el HANDLE del cliente
PROMPT ****************************************************************

create TABLE AUX_G4389_IRIS_12
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
SELECT /*+ parallel(PCDW,4) */
  I11.ID_TRANSACCION,
  I11.FECHA_HORA_RECARGA,
  I11.FECHA_RECARGA,
  I11.CELLULAR_NUMBER_CLI,
  PCDW.PCE_HANDLE HANDLE_CLIENTE,
  I11.ID_NEGOCIO_CLIENTE,
  I11.DESC_NEGOCIO_CLIENTE,
  I11.ID_MERCADO_CLIENTE,
  I11.DESC_MERCADO_CLIENTE,
  I11.RET_MSISDN,
  I11.ID_OFERTA_COMPRADA,
  I11.NOMBRE_OFERTA_COMPRADA,
  I11.TIPO_OFERTA_COMPRADA,
  I11.NOMBRE_CAMPANA_COMPRADA,
  I11.CANAL,
  I11.MONTO_ORIGINAL_CLI,
  I11.MONTO_RECARGA_CLI,
  I11.MONTO_ADICIONAL_CLI,
  I11.CANTIDAD_TRANSACCINES,
  I11.MONTO_EXTRA_UP,
  I11.MONTO_EXTRA_RECO_RECARGA ,
  I11.OFERTAS_RECOMENDADAS,
  I11.ID_OFERTA_RECOMENDADA,
  I11.NOMBRE_OFERTA_RECOMENDADA,
  I11.NOMBRE_CAMPANA_RECOMENDADA, 
  I11.TIPO_OFERTA_RECOMENDADA 
FROM AUX_G4389_IRIS_11 I11
	   LEFT JOIN &v_esquema_rac8.PREPAY_CELLULARS PCDW --para obtener el HANDLE del cliente
     ON (I11.CELLULAR_NUMBER_CLI = PCDW.CELLULAR_NUMBER)
     

/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/ 
