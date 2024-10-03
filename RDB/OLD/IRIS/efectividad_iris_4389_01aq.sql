prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01aq.sql 
prompt Autor......: Miguel peralta
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Inserta en la tabla final OFERTAS_IRIS el universo de ofertas y campañas.		
prompt *****************************************************************
prompt Historia del Proceso
prompt Fecha        Por           Descripcion
prompt **********   ***********   **************************************
prompt 17/7/2020   M. Peralta     Creacion del script
prompt *****************************************************************
prompt Seteos Iniciales
prompt *****************************************************************
@/racing/replica/seteos_iniciales.sql 
alter session disable parallel dml 
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
PROMPT Parámetro: [dbl_iris]          - Valor: [&v_dbl_iris]

/

PROMPT ****************************************************************
PROMPT Borrando datos de tabla OFERTAS_IRIS
PROMPT ****************************************************************
delete  from OFERTAS_IRIS
/
PROMPT ****************************************************************
PROMPT Insertando datos de tabla OFERTAS_IRIS
PROMPT ****************************************************************
insert into OFERTAS_IRIS
(
SELECT DISTINCT ID_OFERTA_RECOMENDADA,NOMBRE_OFERTA_RECOMENDADA, NOMBRE_CAMPANA_RECOMENDADA
FROM B_MEDICION_RECARGAS_IRIS
WHERE TIPO_OFERTA_COMPRADA <> 0
)
/
prompt ****************************************************************
prompt Actualizando indice de tabla
prompt ****************************************************************
UPDATE ACTUALIZACION_RACING
SET    ACT_OLD_DATE 			= ACT_ACTUALIZ_DATE,
       ACT_ACTUALIZ_DATE 	= SYSDATE
WHERE  ACT_TABLE_NAME 		= 'EFECTIVIDAD_IRIS'
/
prompt ****************************************************************
prompt Actualizando tabla de parametros
prompt ****************************************************************
UPDATE PARAM_ACTUALIZ_RACING
SET PAR_VALUE_DATE = TRUNC(SYSDATE)
WHERE PAR_PROCEDURE_NAME 	= 'EFECTIVIDAD_IRIS'
AND PAR_PARAMETER_NAME 		= 'FECHA_PROCESO'
/
COMMIT
/
prompt ****************************************************************
prompt Fin Script
prompt ****************************************************************
select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') "Hora Fin" from dual
/