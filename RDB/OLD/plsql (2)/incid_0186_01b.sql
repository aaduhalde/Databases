PROMPT ****************************************************************
PROMPT * * * * * * * * P R O C E S S	M O N I T O R * * * * * * * * *
PROMPT ****************************************************************
PROMPT Archivo....: incid01b.sql
PROMPT Autor......:
PROMPT Reviso.....:
PROMPT Produccion.:
PROMPT
PROMPT Descripcion: obtiene el account_id
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
PROMPT 20/02/2004 F.tarasconi Se obtiene el campo ACCOUNT_ID, desde la
PROMPT								tabla racing.documents@rac8
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
ALTER SESSION SET sort_area_size = 20000000
/
ALTER SESSION SET hash_area_size = 20000000
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

PROMPT ****************************************************************
PROMPT Parametros Leidos
PROMPT Espacio de Tabla - [&espacio_tabla]
PROMPT Esquema - [&esquema]
PROMPT ****************************************************************

PROMPT ****************************************************************
PROMPT Creando Tabla: aux_inc_id
PROMPT ****************************************************************
CREATE TABLE aux_inc_id
TABLESPACE &espacio_tabla
PCTFREE 0
NOLOGGING 
parallel 4
AS
SELECT	/*+ ORDERED USE_HASH(B) PARALLEL(a,4) PARALLEL(b,4) PARALLEL(s,4) */
			trunc(s.sch_end_date) sch_end_date,
			a.dod_doc_dct_id,
			a.dod_sch_id,
			a.dod_inc_id,
			b.doc_acc_id account_id,
			a.dod_clu_cellular_number,
			SUM (a.dod_amount) dod_amount,
			SUM (a.dod_amount_tot) dod_amount_tot,
			SUM (a.dod_amount_vat) dod_amount_vat,
			SUM (a.dod_quantity) dod_quantity
	 FROM   aux_inc_id_prod a,
			stl.documents@prod b,
			stl.schedulers@prod s
	WHERE   a.dod_doc_cmp_id = b.doc_cmp_id AND
			a.dod_doc_dct_id = b.doc_dct_id AND
			a.dod_doc_id = b.doc_id AND
			a.dod_doc_letter = b.doc_letter AND
            a.dod_sch_id = s.sch_id
GROUP BY    trunc(s.sch_end_date),
			a.dod_doc_dct_id,
			a.dod_sch_id,
			a.dod_inc_id,
			b.doc_acc_id,
			a.dod_clu_cellular_number
/


SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo
  FROM DUAL
/
