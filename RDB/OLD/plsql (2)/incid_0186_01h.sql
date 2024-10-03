PROMPT ****************************************************************
PROMPT * * * * * * * * P R O C E S S	M O N I T O R * * * * * * * * *
PROMPT ****************************************************************
PROMPT Archivo....: incid01h.sql
PROMPT Autor......:
PROMPT Reviso.....:
PROMPT Produccion.:
PROMPT
PROMPT Descripcion:
PROMPT
PROMPT Nota:
PROMPT
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

col val1 new_value espacio_tabla
col val2 new_value esquema
select  pck_core.fc_get_parameter('CORE','TBS_ADMIN') val1 from dual
/
select  pck_core.fc_get_parameter('CORE','ESQUEMA_RAC8') val2 from dual
/
column val4 new_value fecha_proceso noprint
SELECT TO_DATE(NVL(par.par_value_date, SYSDATE),'DD/MM/YYYY') val4
FROM   param_actualiz_racing par
 WHERE par.par_procedure_name = 'INC_ID_CEL'
   AND par.par_parameter_name = 'FECHA_PROCESO'
/
PROMPT ****************************************************************
PROMPT Parametros Leidos
PROMPT Espacio de Tabla - [&espacio_tabla]
PROMPT Esquema ........ - [&esquema]
PROMPT Fecha_Proceso .. - [&fecha_proceso]
PROMPT ****************************************************************

PROMPT ****************************************************************
PROMPT Creando Tabla: aux_incid_cred_curr
PROMPT ****************************************************************
CREATE TABLE aux_incid_cred_curr
PCTFREE 0
TABLESPACE &espacio_tabla
NOLOGGING AS
SELECT /*+PARALLEL (CLC,4)*/
		 clc.cellular_number,
		 clc.start_date,
		 clc.credit_limit credit_limit_cellular
  FROM &esquema.credit_limit_cellulars clc
 WHERE end_date IS NULL OR
		 end_date >= '&fecha_proceso'
/
SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo
  FROM DUAL
/
