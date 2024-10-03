
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01ao.sql 
prompt Autor......: Miguel Peralta
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Unimos las transacciones de los clientes que realizaron recargas y no compraron paquetes 
prompt 				      con los clientes que realizaron recargas y ademas compraron paquetes.
prompt *****************************************************************
prompt Historia del Proceso
prompt Fecha        Por           Descripcion
prompt **********   ***********   **************************************
prompt 1/07/2020   M. Peralta     Creacion del script
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
COL dbl_iris new_value v_dbl_iris	noprint 
SELECT  par_value_varchar2 dbl_iris
FROM  param_actualiz_racing
WHERE par_procedure_name = 'CORE'
AND par_parameter_name = 'DBL_IRIS'
/
COL esquema_iris_d new_value v_esquema_iris_d	noprint 
SELECT  par_value_varchar2 esquema_iris_d
FROM  param_actualiz_racing
WHERE par_procedure_name = 'CORE'
AND par_parameter_name = 'ESQUEMA_IRIS_D'
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
PROMPT Parámetro: [esquema_iris_d]    - Valor: [&v_esquema_iris_d]
PROMPT Parámetro: [dbl_iris]          - Valor: [&v_dbl_iris]
PROMPT ****************************************************************
PROMPT Actualizando datos en tabla 
PROMPT ****************************************************************
PROMPT Borrando datos de tabla 
PROMPT ****************************************************************
PROMPT ****************************************************************
PROMPT Creando AUX_G4389_IRIS_39
PROMPT ****************************************************************

create TABLE AUX_G4389_IRIS_39
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
SELECT
  I34.ID_TRANSACCION ,
  I34.FECHA_HORA_RECARGA,
  I34.FECHA_RECARGA,
  I34.CELLULAR_NUMBER_CLI,
  I34.HANDLE_CLIENTE,
  I34.ID_NEGOCIO_CLIENTE,
  I34.DESC_NEGOCIO_CLIENTE,
  I34.ID_MERCADO_CLIENTE,
  I34.DESC_MERCADO_CLIENTE,
  I34.SEGMENTO_CLIENTE,
  I34.NRO_AGENTE,
  I34.CELLULAR_NUMBER_PSR,
  I34.CIUDAD_PSR,
  I34.PROVINCIA_PSR,
  I34.LATITUD,
  I34.LONGITUD,
  I34.ID_OFERTA_COMPRADA,
  I34.NOMBRE_OFERTA_COMPRADA,
  I34.TIPO_OFERTA_COMPRADA,
  I34.NOMBRE_CAMPANA_COMPRADA,
  I34.CANAL,
  I34.MONTO_ORIGINAL_CLI,
  I34.MONTO_RECARGA_CLI,
  I34.MONTO_ADICIONAL_CLI,
  I34.CANTIDAD_TRANSACCINES,
  I34.MONTO_EXTRA_UP,
  I34.MONTO_EXTRA_RECO_RECARGA ,
  I34.OFERTAS_RECOMENDADAS,
  I34.ID_OFERTA_RECOMENDADA,
  I34.NOMBRE_OFERTA_RECOMENDADA,
  I34.NOMBRE_CAMPANA_RECOMENDADA, 
  I34.TIPO_OFERTA_RECOMENDADA,
  I34.MONTO_OFERTA_RECOMENDADA ,
  I34.ID_PAQUETE,
  I34.CANTIDAD_PAQUETES,
  CASE WHEN I34.TIPO_OFERTA_COMPRADA = 0 THEN 'N' ELSE 'Y' END CONVERSION
FROM AUX_G4389_IRIS_34 I34
UNION ALL
SELECT
  I38.ID_TRANSACCION,
  I38.FECHA_HORA_RECARGA,
  I38.FECHA_RECARGA,
  I38.CELLULAR_NUMBER_CLI,
  I38.HANDLE_CLIENTE,
  I38.ID_NEGOCIO_CLIENTE,
  I38.DESC_NEGOCIO_CLIENTE,
  I38.ID_MERCADO_CLIENTE,
  I38.DESC_MERCADO_CLIENTE,
  I38.SEGMENTO_CLIENTE,
  I38.NRO_AGENTE,
  I38.CELLULAR_NUMBER_PSR,
  I38.CIUDAD_PSR,
  I38.PROVINCIA_PSR,
  I38.LATITUD,
  I38.LONGITUD,
  I38.ID_OFERTA_COMPRADA,
  I38.NOMBRE_OFERTA_COMPRADA,
  I38.TIPO_OFERTA_COMPRADA,
  I38.NOMBRE_CAMPANA_COMPRADA,
  I38.CANAL,
  I38.MONTO_ORIGINAL_CLI,
  I38.MONTO_RECARGA_CLI,
  I38.MONTO_ADICIONAL_CLI,
  I38.CANTIDAD_TRANSACCINES,
  I38.MONTO_EXTRA_UP,
  I38.MONTO_EXTRA_RECO_RECARGA ,
  I38.OFERTAS_RECOMENDADAS,
  I38.ID_OFERTA_RECOMENDADA,
  I38.NOMBRE_OFERTA_RECOMENDADA,
  I38.NOMBRE_CAMPANA_RECOMENDADA, 
  I38.TIPO_OFERTA_RECOMENDADA,
  I38.MONTO_OFERTA_RECOMENDADA ,
  I38.ID_PAQUETE,
  I38.CANTIDAD_PAQUETES,
  CASE WHEN I38.TIPO_OFERTA_COMPRADA = 0 THEN 'N' ELSE 'Y' END CONVERSION
FROM AUX_G4389_IRIS_38 I38
/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/ 
