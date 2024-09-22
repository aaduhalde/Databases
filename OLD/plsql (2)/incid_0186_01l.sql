PROMPT ****************************************************************
PROMPT * * * * * * * * P R O C E S S	M O N I T O R * * * * * * * * *
PROMPT ****************************************************************
PROMPT Archivo....: incid01l.sql
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
PROMPT 20/02/2004 F.tarasconi Se agrega el campo cbt_id
PROMPT 27/09/2005 Dai R. 		Se agrega el campo pro_mode_type
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
ALTER SESSION SET hash_area_size= 100000000
/
ALTER SESSION SET sort_area_size = 100000000
/

PROMPT ****************************************************************
PROMPT Leyendo parametros
PROMPT ****************************************************************

col val1 new_value espacio_tabla

select  pck_core.fc_get_parameter('CORE','TBS_GRANDES_D') val1 from dual
/

PROMPT ****************************************************************
PROMPT Parametros Leidos
PROMPT Espacio de Tabla - [&espacio_tabla]
PROMPT ****************************************************************

PROMPT ****************************************************************
PROMPT Creando Tabla: aux_inc_id_cel
PROMPT ****************************************************************
CREATE TABLE aux_inc_id_cel
TABLESPACE &espacio_tabla
PCTFREE 0
NOLOGGING AS
SELECT 
		 dod_sch_id,
		 sch_end_date,
		 c.cellular_number,
		 collection_entity_type,
		 inc_gla_id,
		 dod_amount,
		 dod_amount_tot,
		 dod_amount_vat,
		 dod_quantity,
		 v.account_id,
		 c.dealer_id,
		 rate_plan_id,
		 activation_date,
		 service_status,
		 market_code,
		 company_id,
		 client_class,
		 credit_limit_cellular,
		 dod_inc_id,
		 cbt_id,
		 c.clu_pro_mode_type pro_mode_type
  FROM aux_incid_cred d,
		 aux_incid_cel c,
		 aux_incid_inv v
 WHERE v.dod_clu_cellular_number = c.cellular_number(+) AND
		 v.dod_clu_cellular_number = d.cellular_number(+)
/
SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo
  FROM DUAL
/
