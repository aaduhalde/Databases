
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01ab.sql 
prompt Autor......: Miguel Peralta
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Se buscan en PREPAY_INTERFACES todos los packs comprados por las líneas  
prompt 							que participan en las recargas a travez de IRIS dentro de las 3 primeras horas pos una recarga.  
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
PROMPT Creando AUX_G4389_IRIS_26
PROMPT ****************************************************************

create TABLE AUX_G4389_IRIS_26
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
SELECT /*+ parallel(OPI,4) */
  I24.FECHA_RECARGA,
  I24.CELLULAR_NUMBER_CLI,
  I24.HANDLE_CLIENTE,
  I24.ID_NEGOCIO_CLIENTE,
  I24.DESC_NEGOCIO_CLIENTE,
  I24.ID_MERCADO_CLIENTE,
  I24.DESC_MERCADO_CLIENTE,
  I24.SEGMENTO_CLIENTE,
  COUNT(DISTINCT OPI.PPI_ADD_DATE) CANTIDAD_PAQUETES
 FROM  AUX_G4389_IRIS_24 I24       
   JOIN &v_esquema_rac8.OL_PREPAY_INTERFACES OPI
       ON (I24.CELLULAR_NUMBER_CLI = OPI.PPI_CLU_CELLULAR_NUMBER)
   JOIN AUX_G4389_IRIS_25 I25
       ON (OPI.PPI_CTY_ID = I25.PKT_ID)
WHERE   PPI_PPS_ID = 'PF'
         AND PPI_IST_ID = 'Y'
         AND TRIM (PPI_GENERIC_DATA) IS NOT NULL
         AND TRIM (PPI_GENERIC_DATA) NOT IN ('P_PACK_PP=Y')
AND TRUNC(PPI_ADD_DATE) = '&v_fecha_proceso'
AND PPI_ADD_DATE BETWEEN I24.FECHA_HORA_RECARGA AND (I24.FECHA_HORA_RECARGA + 3/24)
GROUP BY 
  I24.FECHA_RECARGA,
  I24.CELLULAR_NUMBER_CLI,
  I24.HANDLE_CLIENTE,
  I24.ID_NEGOCIO_CLIENTE,
  I24.DESC_NEGOCIO_CLIENTE,
  I24.ID_MERCADO_CLIENTE,
  I24.DESC_MERCADO_CLIENTE,
  I24.SEGMENTO_CLIENTE

/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/ 
