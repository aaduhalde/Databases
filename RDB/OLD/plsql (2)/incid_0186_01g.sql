PROMPT ****************************************************************
PROMPT * * * * * * * * P R O C E S S	M O N I T O R * * * * * * * * *
PROMPT ****************************************************************
PROMPT Archivo....: incid01g.sql
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
PROMPT 20/02/2004 F.tarasconi Se obtiene el campo account_id desde la tabla
PROMPT								racing.cellulars
PROMPT 27/09/2005 Dai R.  		Se obtiene el campo pro_mode_type desde la tabla
PROMPT								racing.cellulars
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
ALTER SESSION SET hash_area_size = 150000000
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
PROMPT Creando Tabla: aux_incid_cel
PROMPT ****************************************************************
CREATE TABLE aux_incid_cel
PCTFREE 0
TABLESPACE &espacio_tabla
NOLOGGING AS
SELECT /*+ parallel (t,4)  parallel (c,4)  parallel (a,4)  parallel (l,4) */
		 c.cellular_number,
		 c.account_id,
		 c.dealer_id,
		 c.rate_plan_id,
		 c.activation_date,
		 c.service_status,
		 c.market_code,
		 a.collection_entity_type,
		 a.company_id,
		 l.client_class,
		 c.cbt_id,
		 c.clu_pro_mode_type
  FROM aux_incid_celulares t,
		 &esquema.cellulars c,
		 &esquema.accounts a,
		 &esquema.clients l
 WHERE c.cellular_number = t.cellular_number AND
		 c.account_id = a.account_id AND
		 a.client_id = l.client_id
/
SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo
  FROM DUAL
/
