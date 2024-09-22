
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01g.sql 
prompt Autor......: Miguel Peralta
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Separamos las Ofertas recomendadas del campo concatenado
prompt 				
prompt *****************************************************************
prompt Historia del Proceso
prompt Fecha        Por           Descripcion
prompt **********   ***********   **************************************
prompt 24/06/2020   M. Peralta     Creacion del script
prompt *****************************************************************
prompt Seteos Iniciales
prompt *****************************************************************

@/racing/replica/seteos_iniciales.sql
select to_char(sysdate, 'yyyy-mm-dd hh24.mi.ss') "Tiempo Inicio" from dual
/
prompt ****************************************************************
prompt Lectura de tablas de parámetros
prompt ****************************************************************

col tbs_admin    		    new_value v_tbs_admin       noprint
col esquema_rac8        new_value v_esquema_rac8    noprint     

SELECT 
   pck_core.fc_get_parameter ('CORE', 'TBS_ADMIN')    tbs_admin,
   pck_core.fc_get_parameter('CORE','ESQUEMA_RAC8') esquema_rac8
FROM DUAL
/
COL esquema_iris new_value v_esquema_iris	noprint 
SELECT  par_value_varchar2 esquema_iris
FROM  param_actualiz_racing
WHERE par_procedure_name = 'CORE'
AND par_parameter_name = 'ESQUEMA_IRIS'
  /
COL fecha_proceso new_value v_fecha_proceso	noprint                                                     
SELECT par_value_date fecha_proceso
FROM PARAM_ACTUALIZ_RACING
WHERE par_procedure_name = 'EFECTIVIDAD_IRIS'
AND par_parameter_name = 'FECHA_PROCESO' 

/
PROMPT ****************************************************************
PROMPT Parámetros
PROMPT ****************************************************************
PROMPT Parámetro: [fecha_proceso]     - Valor: [&v_fecha_proceso]
PROMPT Parámetro: [esquema_rac8]      - Valor: [&v_esquema_rac8]
PROMPT Parámetro: [tbs_admin]         - Valor: [&v_tbs_admin]
PROMPT Parámetro: [esquema_iris]      - Valor: [&v_esquema_iris]
PROMPT ****************************************************************
PROMPT Actualizando datos en tabla 
PROMPT ****************************************************************
PROMPT Borrando datos de tabla 
PROMPT ****************************************************************
PROMPT ****************************************************************
PROMPT Separamos las Ofertas recomendadas del campo concatenado
PROMPT ****************************************************************

create TABLE AUX_G4389_IRIS_5
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
SELECT 
  I3.ID_TRANSACCION,
  I3.FECHA_HORA_RECARGA,
  I3.FECHA_RECARGA,
  I3.CELLULAR_NUMBER_CLI,
  I3.RET_MSISDN,
  I3.ID_OFERTA_COMPRADA,
  I3.NOMBRE_OFERTA_COMPRADA,
  I3.TIPO_OFERTA_COMPRADA,
  I3.NOMBRE_CAMPANA_COMPRADA,
  I3.CANAL,
  I3.MONTO_ORIGINAL_CLI,
  I3.MONTO_RECARGA_CLI,
  I3.MONTO_ADICIONAL_CLI,
  I3.CANTIDAD_TRANSACCINES,
  I3.MONTO_EXTRA_UP,
  I3.MONTO_EXTRA_RECO_RECARGA ,
  I3.OFERTAS_RECOMENDADAS,
  IOFD.OFFER_N ID_OFERTA_RECOMENDADA,
  IOFD.DESC_OFFER_N NOMBRE_OFERTA_RECOMENDADA,
  IOFD.CAMPAING_NAME_N NOMBRE_CAMPANA_RECOMENDADA   
FROM AUX_G4389_IRIS_3 I3
     --A CONTINUACION EL SEPARADOR DE LAS OFERTAS CONCATENADAS
     JOIN (
            SELECT OFFER.* ,SUBSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 1, '', 1), 1, INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 1, '', 1), '##')-1) OFFER_N, SUBSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 1, '', 1), INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 1, '', 1), '##')+2, (INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 1, '', 1), '##',1,2))-(INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 1, '', 1), '##',1,1)+2)) DESC_OFFER_N, SUBSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 1, '', 1), INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 1, '', 1), '##',1,2)+2) CAMPAING_NAME_N
            FROM &v_esquema_iris.IRISOFFERFETCHTXNDATA OFFER 
            WHERE TR_DATE = '&v_fecha_proceso'
            UNION ----
            SELECT OFFER.* , SUBSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 2, '', 1), 1, INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 2, '', 1), '##')-1),SUBSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 2, '', 1), INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 2, '', 1), '##')+2, (INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 2, '', 1), '##',1,2))-(INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 2, '', 1), '##',1,1)+2)),SUBSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 2, '', 1), INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 2, '', 1), '##',1,2)+2)
            FROM &v_esquema_iris.IRISOFFERFETCHTXNDATA OFFER
            WHERE TR_DATE = '&v_fecha_proceso'
            UNION ----
            SELECT OFFER.* , SUBSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 3, '', 1), 1, INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 3, '', 1), '##')-1),SUBSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 3, '', 1), INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 3, '', 1), '##')+2, (INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 3, '', 1), '##',1,2))-(INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 3, '', 1), '##',1,1)+2)),SUBSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 3, '', 1), INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 3, '', 1), '##',1,2)+2)
            FROM &v_esquema_iris.IRISOFFERFETCHTXNDATA OFFER
            WHERE TR_DATE = '&v_fecha_proceso'
            UNION ----
            SELECT OFFER.* , SUBSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 4, '', 1), 1, INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 4, '', 1), '##')-1) ,SUBSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 4, '', 1), INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 4, '', 1), '##')+2, (INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 4, '', 1), '##',1,2))-(INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 4, '', 1), '##',1,1)+2)),SUBSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 4, '', 1), INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 4, '', 1), '##',1,2)+2)
            FROM &v_esquema_iris.IRISOFFERFETCHTXNDATA OFFER
            WHERE TR_DATE = '&v_fecha_proceso'
            UNION ----
            SELECT OFFER.* , SUBSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 5, '', 1), 1, INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 5, '', 1), '##')-1),SUBSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 5, '', 1), INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 5, '', 1), '##')+2, (INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 5, '', 1), '##',1,2))-(INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 5, '', 1), '##',1,1)+2)),SUBSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)', 1, 5, '', 1), INSTR(REGEXP_SUBSTR( eligible_offers, '(.*?)(####|$)',1, 5, '', 1), '##',1,2)+2)
            FROM &v_esquema_iris.IRISOFFERFETCHTXNDATA OFFER
            WHERE TR_DATE = '&v_fecha_proceso'
          ) IOFD
      ON (TRIM(IOFD.TR_ID) = TRIM(I3.ID_TRANSACCION) AND IOFD.OFFER_N IS NOT NULL) 
     --
  

/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/ 
