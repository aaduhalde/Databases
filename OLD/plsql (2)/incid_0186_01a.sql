PROMPT ****************************************************************
PROMPT * * * * * * * * P R O C E S S	M O N I T O R * * * * * * * * *
PROMPT ****************************************************************
PROMPT Archivo....: incid01a.sql
PROMPT Autor......:
PROMPT Reviso.....:
PROMPT Produccion.:
PROMPT
PROMPT Descripcion: Recrea tabla inc_id
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
PROMPT 20/02/2004 F.tarasconi Se obtiene los campos DOD_DOC_CMP_ID,
PROMPT								DOD_DOC_ID, y DOD_DOC_LETTER desde la
PROMPT								tabla document_details@prod
PROMPT 28/09/2005 Nazareno Oviedo Estandarizacion de los scripts
PROMPT 26/12/2022 Alejandro Duhalde, exclusion documento tipo FT
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

col val1 new_value espacio_tabla noprint
col val2 new_value min_sch_id noprint
col val3 new_value max_sch_id noprint
col val4 new_value esquema    noprint
COL val5 new_value fecha_proceso noprint

SELECT  pck_core.fc_get_parameter('CORE','TBS_ADMIN') val1 from dual
/
SELECT  pck_core.fc_get_parameter('CORE','ESQUEMA_RAC8') val4 from dual
/
SELECT TO_DATE(NVL(par.par_value_date, SYSDATE),'DD/MM/YYYY') val5
FROM   &esquema.param_actualiz_racing par
 WHERE par.par_procedure_name = 'INC_ID_CEL'
   AND par.par_parameter_name = 'FECHA_PROCESO'
/
SELECT min(sch_id) val2, max(sch_id) val3 from &esquema.schedulers
WHERE  sch_end_date > TO_DATE (LAST_DAY (ADD_MONTHS (('&fecha_proceso'), -1))) 
AND    sch_end_date < '&fecha_proceso' 
/
PROMPT ****************************************************************
PROMPT Parametros Leidos
PROMPT Espacio de Tabla - [&espacio_tabla]
PROMPT Esquema ........ - [&esquema]
PROMPT Fecha_Proceso .. - [&fecha_proceso]
PROMPT Min sch ........ - [&min_sch_id]
PROMPT Max sch ........ - [&max_sch_id]

PROMPT ****************************************************************
PROMPT ****************************************************************
PROMPT Creando Tabla: aux_inc_id_prod
PROMPT ****************************************************************

CREATE TABLE aux_inc_id_prod
TABLESPACE &espacio_tabla
PCTFREE 0
NOLOGGING
AS
SELECT	/*+ ORDERED PARALLEL(B,8) */
			dod_doc_dct_id,
			dod_sch_id,
			dod_inc_id,
			dod_doc_cmp_id,
			dod_doc_id,
			dod_doc_letter,
			dod_clu_cellular_number,
			SUM (dod_amount) dod_amount,
			SUM (dod_amount_tot) dod_amount_tot,
			SUM (dod_amount_vat) dod_amount_vat,
			SUM (dod_quantity) dod_quantity
    FROM stl.document_details@prod b
	WHERE dod_sch_id between &min_sch_id AND &max_sch_id
	AND   dod_doc_dct_id NOT IN ('PR','FT')
GROUP BY 
			dod_doc_dct_id,
			dod_sch_id,
			dod_inc_id,
			dod_doc_cmp_id,
			dod_doc_id,
			dod_doc_letter,
			dod_clu_cellular_number
/
SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo
  FROM DUAL
/
