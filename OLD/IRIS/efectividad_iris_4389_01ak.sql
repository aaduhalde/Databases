
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01ak.sql 
prompt Autor......: Miguel Peralta
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Nos quedamos con los datos de las recargas de clientes que compraron paquetes de datos.  
prompt 				
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
PROMPT Creando AUX_G4389_IRIS_35
PROMPT ****************************************************************

create TABLE AUX_G4389_IRIS_35
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
SELECT
  I23.ID_TRANSACCION,
  I23.FECHA_HORA_RECARGA,
  I23.FECHA_RECARGA,
  I23.CELLULAR_NUMBER_CLI,
  I23.HANDLE_CLIENTE,
  I23.ID_NEGOCIO_CLIENTE,
  I23.DESC_NEGOCIO_CLIENTE,
  I23.ID_MERCADO_CLIENTE,
  I23.DESC_MERCADO_CLIENTE,
  I23.SEGMENTO_CLIENTE,
  I23.NRO_AGENTE,
  I23.CELLULAR_NUMBER_PSR,
  I23.CIUDAD_PSR,
  I23.PROVINCIA_PSR,
  I23.LATITUD,
  I23.LONGITUD,
  I23.ID_OFERTA_COMPRADA,
  I23.NOMBRE_OFERTA_COMPRADA,
  I23.TIPO_OFERTA_COMPRADA,
  I23.NOMBRE_CAMPANA_COMPRADA,
  I23.CANAL,
  I23.MONTO_ORIGINAL_CLI,
  I23.MONTO_RECARGA_CLI,
  I23.MONTO_ADICIONAL_CLI,
  I23.CANTIDAD_TRANSACCINES,
  I23.MONTO_EXTRA_UP,
  I23.MONTO_EXTRA_RECO_RECARGA ,
  I23.OFERTAS_RECOMENDADAS,
  I23.ID_OFERTA_RECOMENDADA,
  I23.NOMBRE_OFERTA_RECOMENDADA,
  I23.NOMBRE_CAMPANA_RECOMENDADA, 
  I23.TIPO_OFERTA_RECOMENDADA,
  I23.MONTO_OFERTA_RECOMENDADA 
FROM AUX_G4389_IRIS_23 I23
WHERE I23.CELLULAR_NUMBER_CLI  IN (
																				SELECT CELLULAR_NUMBER_CLI
																				FROM AUX_G4389_IRIS_33
																		 )

/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/ 
