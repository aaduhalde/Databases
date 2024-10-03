prompt ****************************************************************
prompt Archivo....: fi_zafra_pospago_3390_05a.sql
prompt Autor......: Leandro Mestrallet
prompt
prompt Descripción: Borrado de tablas auxiliares.
prompt
prompt ****************************************************************
prompt Historia del Proceso
prompt
prompt Fecha 				Por 					Descripcion
prompt **********  *******    *********************************************
prompt 01/12/2016  L.Mestrallet  Creación del script.
prompt ***************************************************************

prompt Seteos Iniciales
prompt ****************************************************************

SET timing ON
SET verify off
SET serveroutput ON SIZE 10000
WHENEVER SQLERROR CONTINUE
ALTER SESSION SET NLS_DATE_FORMAT='dd/mm/yyyy'
/

select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') "Hora Inicio" from dual
/

prompt ****************************************************************
prompt Eliminando tables auxiliaries
prompt ****************************************************************

DROP TABLE AUX_3390_ZAFRA_POSP_01 PURGE
/
DROP TABLE AUX_3390_ZAFRA_POSP_02 PURGE
/
DROP TABLE AUX_3390_ZAFRA_POSP_03 PURGE
/
DROP TABLE AUX_3390_ZAFRA_POSP_04 PURGE
/
DROP TABLE AUX_3390_ZAFRA_POSP_05 PURGE
/
DROP TABLE AUX_3390_ZAFRA_POSP_06 PURGE
/
DROP TABLE AUX_3390_ZAFRA_POSP_07 PURGE
/
select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') "Hora Fin" from dual
/
