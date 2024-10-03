PROMPT ****************************************************************
PROMPT * * * * * * * * P R O C E S S	M O N I T O R * * * * * * * * *
PROMPT ****************************************************************
PROMPT Archivo....: incid01d.sql
PROMPT Autor......:
PROMPT Reviso.....:
PROMPT Produccion.:
PROMPT
PROMPT Descripcion:
PROMPT
PROMPT Nota: Borra la tabla auxiliar aux_tmp_inc_id
PROMPT		 Actualiza la tabla actualizacion_racing
PROMPT
PROMPT ****************************************************************
PROMPT Historia del Proceso
PROMPT
PROMPT Fecha		Por			Descripcion
PROMPT ********** *******		*****************************************
PROMPT								Creacion del script
PROMPT 28/09/2005 Nazareno Oviedo Estandarizacion de los scripts
PROMPT
PROMPT ****************************************************************
PROMPT Seteos Iniciales
PROMPT ****************************************************************
SET timing on
SET serveroutput on size 10000
WHENEVER sqlerror exit rollback
ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy'
/
SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo
  FROM DUAL
/

PROMPT ****************************************************************
PROMPT Leyendo parametros
PROMPT ****************************************************************
col val1 new_value yyyymm
col val2 new_value esquema
SELECT TO_CHAR (NVL(par.par_value_date, SYSDATE), 'yyyymm') val1
FROM   param_actualiz_racing par
 WHERE par.par_procedure_name = 'INC_ID_CEL'
   AND par.par_parameter_name = 'FECHA_PROCESO'
/
select  pck_core.fc_get_parameter('CORE','ESQUEMA_RAC8') val2 from dual
/
PROMPT ****************************************************************
PROMPT Parametros Leidos
PROMPT Esquema - [&esquema]
PROMPT ****************************************************************
--ALTER TABLE &&esquema.inc_id TRUNCATE PARTITION incid_&yyyymm
--ALTER TABLE inc_id TRUNCATE PARTITION incid_&yyyymm
/
PROMPT ****************************************************************
PROMPT Insertando en Tabla: INC_ID
PROMPT ****************************************************************
--INSERT INTO &&esquema.inc_id 
INSERT /*+ APPEND parallel(i,4) */  INTO inc_id i
	SELECT /*+ PARALLEL(a,4) */ *
	  FROM aux_tmp_inc_id a
/

UPDATE actualizacion_racing
	SET act_actualiz_date = SYSDATE,
		 act_old_date = act_actualiz_date
 WHERE act_table_name = 'INC_ID'
/
COMMIT
/

SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo
  FROM DUAL
/
