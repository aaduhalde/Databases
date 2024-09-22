PROMPT ****************************************************************
PROMPT * * * * * * * * P R O C E S S	M O N I T O R * * * * * * * * *
PROMPT ****************************************************************
PROMPT Archivo....: incid01c.sql
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
PROMPT
PROMPT 28/09/2005 Nazareno Oviedo Estandarizacion de los scripts
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
PROMPT Creando Tabla: aux_tmp_inc_id
PROMPT ****************************************************************
CREATE TABLE aux_tmp_inc_id
TABLESPACE &espacio_tabla
PCTFREE 0
NOLOGGING AS
SELECT	/*+ PARALLEL(C,4) */
			sch_end_date,
			dod_doc_dct_id,
			dod_sch_id,
			dod_inc_id,
			SUM (dod_amount) dod_amount,
			SUM (dod_amount_tot) dod_amount_tot,
			SUM (dod_amount_vat) dod_amount_vat,
			SUM (dod_quantity) dod_quantity
	 FROM aux_inc_id c
GROUP BY sch_end_date,
			dod_doc_dct_id,
			dod_sch_id,
			dod_inc_id
/
SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo
  FROM DUAL
/
