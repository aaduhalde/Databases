
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01ai.sql 
prompt Autor......: Miguel Peralta
prompt Reviso.....:
prompt Produccion.:
prompt Descripci�n: Universo de Clientes que realizaron recargas y ademas compraron paquetes de datos.  
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
prompt Lectura de tablas de par�metros
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
PROMPT Par�metros
PROMPT ****************************************************************
PROMPT Par�metro: [fecha_proceso]     - Valor: [&v_fecha_proceso]
PROMPT Par�metro: [esquema_rac8]      - Valor: [&v_esquema_rac8]
PROMPT Par�metro: [tbs_admin]         - Valor: [&v_tbs_admin]
PROMPT Par�metro: [esquema_iris_d]    - Valor: [&v_esquema_iris_d]
PROMPT Par�metro: [dbl_iris]          - Valor: [&v_dbl_iris]
PROMPT ****************************************************************
PROMPT Actualizando datos en tabla 
PROMPT ****************************************************************
PROMPT Borrando datos de tabla 
PROMPT ****************************************************************
PROMPT ****************************************************************
PROMPT Creando AUX_G4389_IRIS_33
PROMPT ****************************************************************

create TABLE AUX_G4389_IRIS_33
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
SELECT DISTINCT I32.CELLULAR_NUMBER_CLI                                   
FROM AUX_G4389_IRIS_32 I32

/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/ 
