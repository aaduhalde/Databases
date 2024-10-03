
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01u.sql 
prompt Autor......: Soledad Zubizarreta
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Obtenemos el Segmento al que corresponde el Cliente
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
PROMPT Creo Tabla AUX_G4389_IRIS_19
PROMPT ****************************************************************
create TABLE AUX_G4389_IRIS_19
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
 SELECT
  I12.ID_TRANSACCION,
  I12.FECHA_HORA_RECARGA,
  I12.FECHA_RECARGA,
  I12.CELLULAR_NUMBER_CLI,
  I12.HANDLE_CLIENTE,
  I12.ID_NEGOCIO_CLIENTE,
  I12.DESC_NEGOCIO_CLIENTE,
  I12.ID_MERCADO_CLIENTE,
  I12.DESC_MERCADO_CLIENTE,
  I18.SEGMENTO,
  I12.RET_MSISDN,
  I12.ID_OFERTA_COMPRADA,
  I12.NOMBRE_OFERTA_COMPRADA,
  I12.TIPO_OFERTA_COMPRADA,
  I12.NOMBRE_CAMPANA_COMPRADA,
  I12.CANAL,
  I12.MONTO_ORIGINAL_CLI,
  I12.MONTO_RECARGA_CLI,
  I12.MONTO_ADICIONAL_CLI,
  I12.CANTIDAD_TRANSACCINES,
  I12.MONTO_EXTRA_UP,
  I12.MONTO_EXTRA_RECO_RECARGA ,
  I12.OFERTAS_RECOMENDADAS,
  I12.ID_OFERTA_RECOMENDADA,
  I12.NOMBRE_OFERTA_RECOMENDADA,
  I12.NOMBRE_CAMPANA_RECOMENDADA, 
  I12.TIPO_OFERTA_RECOMENDADA 
FROM 
     AUX_G4389_IRIS_12 I12
      LEFT JOIN 
         AUX_G4389_IRIS_18 I18
         ON I18.NIM=I12.CELLULAR_NUMBER_CLI
/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/ 