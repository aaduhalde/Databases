
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01i.sql 
prompt Autor......: Miguel Peralta
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Obtenemos nombre y tipo de las ofertas recomendadas
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
COL dbl_iris new_value v_dbl_iris	noprint 
SELECT  par_value_varchar2 dbl_iris
FROM  param_actualiz_racing
WHERE par_parameter_name = 'DBL_IRIS'
/
COL esquema_iris_d new_value v_esquema_iris_d	noprint 
SELECT  par_value_varchar2 esquema_iris_d
FROM  param_actualiz_racing
WHERE  par_parameter_name = 'ESQUEMA_IRIS_D'
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
PROMPT Obtenemos nombre y tipo de las ofertas recomendadas
PROMPT ****************************************************************

create TABLE AUX_G4389_IRIS_7
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
SELECT 
  I6.ID_TRANSACCION,
  I6.FECHA_HORA_RECARGA,
  I6.FECHA_RECARGA,
  I6.CELLULAR_NUMBER_CLI,
  I6.RET_MSISDN,
  I6.ID_OFERTA_COMPRADA,
  I6.NOMBRE_OFERTA_COMPRADA,
  I6.TIPO_OFERTA_COMPRADA,
  I6.NOMBRE_CAMPANA_COMPRADA,
  I6.CANAL,
  I6.MONTO_ORIGINAL_CLI,
  I6.MONTO_RECARGA_CLI,
  I6.MONTO_ADICIONAL_CLI,
  I6.CANTIDAD_TRANSACCINES,
  I6.MONTO_EXTRA_UP,
  I6.MONTO_EXTRA_RECO_RECARGA ,
  I6.OFERTAS_RECOMENDADAS,
  I6.ID_OFERTA_RECOMENDADA,
  I6.NOMBRE_OFERTA_RECOMENDADA,
  I6.NOMBRE_CAMPANA_RECOMENDADA,  
  --OFDET.OFFERNAME NOMBRE_OFERTA_RECOMENDADA,
  OFDET.INTERFACE TIPO_OFERTA_RECOMENDADA 
FROM AUX_G4389_IRIS_6 I6
	LEFT JOIN &v_esquema_iris_d.IRISOFFERDETAILS@&v_dbl_iris OFDET
		ON(I6.ID_OFERTA_RECOMENDADA = OFDET.OFFERID)

/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/ 
