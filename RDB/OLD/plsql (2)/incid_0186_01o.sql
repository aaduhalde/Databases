PROMPT ****************************************************************
PROMPT * * * * * * * * P R O C E S S	M O N I T O R * * * * * * * * *
PROMPT ****************************************************************
PROMPT Archivo....: incid01o.sql
PROMPT Autor......: Fernando Tarasconi
PROMPT Reviso.....:
PROMPT Produccion.:
PROMPT
PROMPT Descripcion:
PROMPT
PROMPT Nota: borra tablas auxiliares
PROMPT
PROMPT
PROMPT ****************************************************************
PROMPT Historia del Proceso
PROMPT
PROMPT Fecha		Por			Descripcion
PROMPT ********** *******		*******************************************
PROMPT 23/02/2004 F.Tarasconi Creacion del script
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

PROMPT
PROMPT ****************************************************************
PROMPT Actualiza tabla actualizacion_racing
PROMPT ****************************************************************
UPDATE actualizacion_racing
	SET act_actualiz_date = SYSDATE,
		 act_old_date = act_actualiz_date,
		 act_value_date = (SELECT TRUNC (MAX (sch_end_date)) FROM inc_id_cel)
 WHERE act_table_name = 'INC_ID_CEL'
/
COMMIT
/


SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo
  FROM DUAL
/

