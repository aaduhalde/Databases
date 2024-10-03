
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01w.sql 
prompt Autor......: Soledad Zubizarreta
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Se obtiene Informacion de Punto de Venta
prompt 				
prompt *****************************************************************
prompt Historia del Proceso
prompt Fecha        Por           Descripcion
prompt **********   ***********   **************************************
prompt 22/06/2020   S.Zubizarreta     Creacion del script
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
PROMPT Creamos AUX_G4389_IRIS_21
PROMPT ****************************************************************
create TABLE AUX_G4389_IRIS_21
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
SELECT
  I19.ID_TRANSACCION,
  I19.FECHA_HORA_RECARGA,
  I19.FECHA_RECARGA,
  I19.CELLULAR_NUMBER_CLI,
  I19.HANDLE_CLIENTE,
  I19.ID_NEGOCIO_CLIENTE,
  I19.DESC_NEGOCIO_CLIENTE,
  I19.ID_MERCADO_CLIENTE,
  I19.DESC_MERCADO_CLIENTE,
  I19.SEGMENTO SEGMENTO_CLIENTE,
  I20.NROAGENTE NRO_AGENTE,
  I20.pospsr CELLULAR_NUMBER_PSR,
  I20.CIUDAD CIUDAD_PSR,
  I20.PCIA PROVINCIA_PSR,
  I20.ADD_LATITUDE LATITUD,
  I20.ADD_LONGITUDE LONGITUD,
  I19.ID_OFERTA_COMPRADA,
  I19.NOMBRE_OFERTA_COMPRADA,
  I19.TIPO_OFERTA_COMPRADA,
  I19.NOMBRE_CAMPANA_COMPRADA,
  I19.CANAL,
  I19.MONTO_ORIGINAL_CLI,
  I19.MONTO_RECARGA_CLI,
  I19.MONTO_ADICIONAL_CLI,
  I19.CANTIDAD_TRANSACCINES,
  I19.MONTO_EXTRA_UP,
  I19.MONTO_EXTRA_RECO_RECARGA ,
  I19.OFERTAS_RECOMENDADAS,
  I19.ID_OFERTA_RECOMENDADA,
  I19.NOMBRE_OFERTA_RECOMENDADA,
  I19.NOMBRE_CAMPANA_RECOMENDADA, 
  I19.TIPO_OFERTA_RECOMENDADA
FROM AUX_G4389_IRIS_19 I19
  LEFT JOIN AUX_G4389_IRIS_20 I20
   ON I19.RET_MSISDN = I20.POSPSR
/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/