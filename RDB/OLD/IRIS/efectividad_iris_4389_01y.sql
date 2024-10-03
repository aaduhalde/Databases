
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01y.sql 
prompt Autor......: Miguel Peralta
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Obtenemos el monto de las ofertas recomendadas solo para tipo Upselling
prompt 				
prompt *****************************************************************
prompt Historia del Proceso
prompt Fecha        Por           Descripcion
prompt **********   ***********   **************************************
prompt 30/06/2020   M. Peralta     Creacion del script
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
PROMPT Obtenemos el monto de las ofertas recomendadas
PROMPT ****************************************************************

create TABLE AUX_G4389_IRIS_23
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
SELECT
  I21.ID_TRANSACCION,
  I21.FECHA_HORA_RECARGA,
  I21.FECHA_RECARGA,
  I21.CELLULAR_NUMBER_CLI,
  I21.HANDLE_CLIENTE,
  I21.ID_NEGOCIO_CLIENTE,
  I21.DESC_NEGOCIO_CLIENTE,
  I21.ID_MERCADO_CLIENTE,
  I21.DESC_MERCADO_CLIENTE,
  I21.SEGMENTO_CLIENTE,
  I21.NRO_AGENTE,
  I21.CELLULAR_NUMBER_PSR,
  I21.CIUDAD_PSR,
  I21.PROVINCIA_PSR,
  I21.LATITUD,
  I21.LONGITUD,
  I21.ID_OFERTA_COMPRADA,
  I21.NOMBRE_OFERTA_COMPRADA,
  I21.TIPO_OFERTA_COMPRADA,
  I21.NOMBRE_CAMPANA_COMPRADA,
  I21.CANAL,
  I21.MONTO_ORIGINAL_CLI,
  I21.MONTO_RECARGA_CLI,
  I21.MONTO_ADICIONAL_CLI,
  I21.CANTIDAD_TRANSACCINES,
  I21.MONTO_EXTRA_UP,
  I21.MONTO_EXTRA_RECO_RECARGA ,
  I21.OFERTAS_RECOMENDADAS,
  I21.ID_OFERTA_RECOMENDADA,
  I21.NOMBRE_OFERTA_RECOMENDADA,
  I21.NOMBRE_CAMPANA_RECOMENDADA, 
  I21.TIPO_OFERTA_RECOMENDADA,
  CASE WHEN TO_NUMBER(I22.PROPERTYVALUE) IS NOT NULL 
  THEN TO_NUMBER(I22.PROPERTYVALUE)
  ELSE 0
  END MONTO_OFERTA_RECOMENDADA 
FROM AUX_G4389_IRIS_21 I21
     LEFT JOIN AUX_G4389_IRIS_22 I22
        ON (I21.ID_OFERTA_RECOMENDADA = I22.OFFERID)

/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/ 
