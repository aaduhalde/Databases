PROMPT ****************************************************************
PROMPT * * * * * * * * P R O C E S S	M O N I T O R * * * * * * * * *
PROMPT ****************************************************************
PROMPT Archivo....: incid01i.sql
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
SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo
  FROM DUAL
/
ALTER SESSION SET hash_area_size=30000000
/
ALTER SESSION SET db_file_multiblock_read_count=16
/

PROMPT ****************************************************************
PROMPT Leyendo parametros
PROMPT ****************************************************************

col val1 new_value espacio_tabla

select  pck_core.fc_get_parameter('CORE','TBS_ADMIN') val1 from dual
/

PROMPT ****************************************************************
PROMPT Parametros Leidos
PROMPT Espacio de Tabla - [&espacio_tabla]
PROMPT ****************************************************************

PROMPT ****************************************************************
PROMPT Creando Tabla: aux_incid_cred_aux
PROMPT ****************************************************************
CREATE TABLE aux_incid_cred_aux
PCTFREE 0
TABLESPACE &espacio_tabla
NOLOGGING AS
SELECT /*+ PARALLEL(c,4) */
		 t.cellular_number,
		 start_date,
		 credit_limit_cellular
  FROM aux_incid_celulares c,
		 aux_incid_cred_curr t
 WHERE c.cellular_number = t.cellular_number
/
SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo
  FROM DUAL
/
