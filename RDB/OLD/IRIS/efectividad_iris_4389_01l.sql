
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01l.sql 
prompt Autor......: Miguel Peralta
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Unimos el universo de Cellulars y Account con CLIENT
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
PROMPT Descripción: Unimos el universo de Cellulars y Account con CLIENT
PROMPT ****************************************************************

create TABLE AUX_G4389_IRIS_10
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
SELECT  /*+ parallel(CLI,4) */
		    I9.CUENTA_CLIENTE CUENTA_CLIENTE,
 		    I9.ID_NEGOCIO_CLIENTE ID_NEGOCIO_CLIENTE,
 		    I9.DESC_NEGOCIO_CLIENTE DESC_NEGOCIO_CLIENTE,
        I9.CELLULAR_CLIENTE CELLULAR_CLIENTE,
        I9.ID_CLIENTE ID_CLIENTE,
        CLI.CLIENT_CATEGORY ID_MERCADO_CLIENTE,
        CASE WHEN CLI.CLIENT_CATEGORY = 'M' THEN 'Masivo'
        WHEN CLI.CLIENT_CATEGORY = 'C' THEN 'Corporativo'
        ELSE NULL
        END DESC_MERCADO_CLIENTE
FROM AUX_G4389_IRIS_9 I9
	LEFT JOIN &v_esquema_rac8.CLIENTS CLI
    ON(I9.ID_CLIENTE = CLI.CLIENT_ID)

/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/ 
