PROMPT ****************************************************************
PROMPT * * * * * * * * P R O C E S S	M O N I T O R * * * * * * * * *
PROMPT ****************************************************************
PROMPT Archivo....: incid01e.sql
PROMPT Autor......:
PROMPT Reviso.....:
PROMPT Produccion.:
PROMPT
PROMPT Descripcion: Recrea tabla inc_id_cel
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
PROMPT 20/02/2004 F.tarasconi Se agrega el campo account_id
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
ALTER SESSION SET sort_area_size = 200000000
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

--parametro agregado por los cambios de SINERGIA, Juan Laquiz, 30/08/2019
col val5 new_value fecha_proceso noprint

SELECT NVL(par.par_value_date, TRUNC(SYSDATE)) val5
FROM   param_actualiz_racing par
 WHERE par.par_procedure_name = 'INC_ID_CEL'
   AND par.par_parameter_name = 'FECHA_PROCESO'
/

--parametro agregado por los cambios de SINERGIA, Juan Laquiz, 30/08/2019
col val6 new_value fecha_sinergia noprint

SELECT par_value_date val6
FROM   param_actualiz_racing par
 WHERE par.par_procedure_name = 'INC_ID_CEL'
   AND par.par_parameter_name = 'FECHA_SINERGIA'
/

PROMPT ****************************************************************
PROMPT Parametros Leidos
PROMPT Espacio de Tabla - [&espacio_tabla]
PROMPT Esquema - [&esquema]
PROMPT ****************************************************************

PROMPT ****************************************************************
PROMPT Creando Tabla: aux_incid_inv
PROMPT ****************************************************************
CREATE TABLE aux_incid_inv
TABLESPACE &espacio_tabla
PCTFREE 0
NOLOGGING AS
  SELECT /*+ parallel (tmp,4)  parallel (i,4) */
         dod_sch_id
        ,sch_end_date
        ,dod_clu_cellular_number
        ,CASE --validacion agregada por los cambios de SINERGIA, Juan Laquiz, 30/08/2019
            WHEN TO_DATE('&FECHA_PROCESO', 'DD/MM/YYYY') >= TO_DATE('&FECHA_SINERGIA', 'DD/MM/YYYY')
            THEN I.INC_SYA_ID
            ELSE I.INC_GLA_ID
            END inc_gla_id
        ,account_id
        ,SUM(dod_amount) dod_amount
        ,SUM(dod_amount_tot) dod_amount_tot
        ,SUM(dod_amount_vat) dod_amount_vat
        ,SUM(dod_quantity) dod_quantity
        ,dod_inc_id
    FROM &esquema.invoice_concepts i
        ,aux_inc_id tmp
   WHERE dod_inc_id = inc_id
GROUP BY dod_sch_id
        ,sch_end_date
        ,dod_clu_cellular_number
        ,CASE
            WHEN TO_DATE('&FECHA_PROCESO', 'DD/MM/YYYY') >= TO_DATE('&FECHA_SINERGIA', 'DD/MM/YYYY')
            THEN I.INC_SYA_ID
            ELSE I.INC_GLA_ID
            END
        ,dod_inc_id
        ,account_id
/
SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo
  FROM DUAL
/
