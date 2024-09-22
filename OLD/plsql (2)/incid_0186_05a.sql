PROMPT ****************************************************************
PROMPT * * * * * * * * P R O C E S S	M O N I T O R * * * * * * * * *
PROMPT ****************************************************************
PROMPT Archivo....: incid05a.sql
PROMPT Autor......:
PROMPT Reviso.....:
PROMPT Produccion.:
PROMPT
PROMPT Descripcion: Dropea las tablas auxiliares
PROMPT
PROMPT Nota:
PROMPT
PROMPT
PROMPT ****************************************************************
PROMPT Historia del Proceso
PROMPT
PROMPT Fecha		Por			Descripcion
PROMPT ********** *******		*******************************************
PROMPT 27/09/2005 Dai R.		Creacion del script
PROMPT
PROMPT ****************************************************************
PROMPT Seteos Iniciales
PROMPT ****************************************************************
SET timing on
SET serveroutput on size 10000
WHENEVER sqlerror continue
SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo
  FROM DUAL
/

PROMPT ****************************************************************
PROMPT Drop de tablas auxiliares
PROMPT ****************************************************************

drop table aux_inc_id_prod
/
drop table aux_inc_id  
/
drop table aux_tmp_inc_id
/
drop table aux_incid_inv
/
drop table aux_incid_celulares
/
drop table aux_incid_cel
/
drop table aux_incid_cred_curr
/
drop table aux_incid_cred_aux
/
drop table aux_incid_cred_max
/
drop table aux_incid_cred
/
drop table aux_inc_id_cel
/

SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo
  FROM DUAL
/
