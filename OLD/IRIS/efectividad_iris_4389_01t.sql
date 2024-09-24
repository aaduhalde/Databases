
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01t.sql 
prompt Autor......: Soledad Zubizarreta
prompt Reviso.....:
prompt Produccion.:
prompt Descripci�n: Unimos clientes Nuevos y viejos
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
PROMPT Creo Tabla AUX_G4389_IRIS_18
PROMPT ****************************************************************
create TABLE AUX_G4389_IRIS_18
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
SELECT 
     NIM,
     RANGO SEGMENTO
FROM
AUX_G4389_IRIS_17
UNION ALL
SELECT 
     NIM,
     SEGMENTO
FROM
AUX_G4389_IRIS_13
/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/ 