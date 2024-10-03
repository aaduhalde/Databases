
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01m.sql 
prompt Autor......: Miguel Peralta
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Unimos los datos transaccionales para agregar NEGOCIO, MERCADO
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
PROMPT Unimos los datos transaccionales para agregar NEGOCIO, MERCADO
PROMPT ****************************************************************

create TABLE AUX_G4389_IRIS_11
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
SELECT 
  I7.ID_TRANSACCION,
  I7.FECHA_HORA_RECARGA,
  I7.FECHA_RECARGA,
  I7.CELLULAR_NUMBER_CLI,
  I10.ID_NEGOCIO_CLIENTE,
  I10.DESC_NEGOCIO_CLIENTE,
  I10.ID_MERCADO_CLIENTE,
  I10.DESC_MERCADO_CLIENTE,
  I7.RET_MSISDN,
  I7.ID_OFERTA_COMPRADA,
  I7.NOMBRE_OFERTA_COMPRADA,
  I7.TIPO_OFERTA_COMPRADA,
  I7.NOMBRE_CAMPANA_COMPRADA,
  I7.CANAL,
  I7.MONTO_ORIGINAL_CLI,
  I7.MONTO_RECARGA_CLI,
  I7.MONTO_ADICIONAL_CLI,
  I7.CANTIDAD_TRANSACCINES,
  I7.MONTO_EXTRA_UP,
  I7.MONTO_EXTRA_RECO_RECARGA ,
  I7.OFERTAS_RECOMENDADAS,
  I7.ID_OFERTA_RECOMENDADA,
  I7.NOMBRE_OFERTA_RECOMENDADA,
  I7.NOMBRE_CAMPANA_RECOMENDADA, 
  I7.TIPO_OFERTA_RECOMENDADA 
FROM AUX_G4389_IRIS_7 I7
	LEFT JOIN AUX_G4389_IRIS_10 I10
        ON (I7.CELLULAR_NUMBER_CLI = I10.CELLULAR_CLIENTE)

/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/ 
