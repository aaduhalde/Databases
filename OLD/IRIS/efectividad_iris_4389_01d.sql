
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01d.sql 
prompt Autor......: Miguel Peralta
prompt Reviso.....:
prompt Produccion.:
prompt Descripci�n: Obtenemos las recargas cuyo ID de oferta son nulos
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
prompt Lectura de tablas de par�metros
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
PROMPT Par�metros
PROMPT ****************************************************************
PROMPT Par�metro: [fecha_proceso]     - Valor: [&v_fecha_proceso]
PROMPT Par�metro: [esquema_rac8]      - Valor: [&v_esquema_rac8]
PROMPT Par�metro: [tbs_admin]         - Valor: [&v_tbs_admin]
PROMPT Par�metro: [esquema_iris]      - Valor: [&v_esquema_iris]
PROMPT ****************************************************************
PROMPT Actualizando datos en tabla 
PROMPT ****************************************************************
PROMPT Borrando datos de tabla 
PROMPT ****************************************************************
PROMPT ****************************************************************
PROMPT Recargas cuyo ID de oferta son nulos
PROMPT ****************************************************************

create TABLE AUX_G4389_IRIS_2
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
SELECT 
	ID_TRANSACCION,
  FECHA_HORA_RECARGA,
  FECHA_RECARGA,
  CELLULAR_NUMBER_CLI,
  RET_MSISDN,
  ID_OFERTA_COMPRADA,
  NOMBRE_OFERTA_COMPRADA,
  TIPO_OFERTA_COMPRADA,
  NOMBRE_CAMPANA_COMPRADA,
  CANAL,
  MONTO_ORIGINAL_CLI,
  MONTO_RECARGA_CLI,
  MONTO_ADICIONAL_CLI,
  CANTIDAD_TRANSACCINES,
  MONTO_EXTRA_UP,
  MONTO_EXTRA_RECO_RECARGA ,
  OFERTAS_RECOMENDADAS   
FROM AUX_G4389_IRIS_1
WHERE UPPER(ID_OFERTA_COMPRADA) = 'NULL'
 

/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/ 
