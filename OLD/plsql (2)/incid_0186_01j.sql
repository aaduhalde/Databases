PROMPT ****************************************************************
PROMPT * * * * * * * * P R O C E S S	M O N I T O R * * * * * * * * *
PROMPT ****************************************************************
PROMPT Archivo....: incid01j.sql
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
PROMPT Creando Tabla: aux_incid_cred_max
PROMPT ****************************************************************
CREATE TABLE aux_incid_cred_max
PCTFREE 0
TABLESPACE &espacio_tabla
NOLOGGING AS
SELECT	t.cellular_number,
			MAX (start_date) start_date
	 FROM aux_incid_cred_aux t
GROUP BY cellular_number
/
SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo
  FROM DUAL
/
