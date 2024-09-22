prompt ****************************************************************
prompt Eliminacion de tablas auxiliares.
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_05a.sql
prompt Autor......: Miguel Peralta
prompt Reviso.....:
prompt Produccion.:
prompt Descripción:  Eliminacion de tablas auxiliares.
prompt *****************************************************************
prompt Historia del Proceso
prompt Fecha        Por           Descripcion
prompt **********   ***********   **************************************
prompt 08/06/2015   M. Peralta     Creacion del script
prompt *****************************************************************
prompt Seteos Iniciales
prompt *****************************************************************

set timing on
set verify off
set serveroutput on size 10000
whenever sqlerror continue
alter session set nls_date_format='dd/mm/yyyy'
/

select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') "Hora Inicio" from dual
/

prompt ****************************************************************
prompt Eliminando tablas auxiliares
prompt ****************************************************************

drop table AUX_G4389_IRIS_TRANSACCIONES purge
/
drop table AUX_G4389_IRIS_OFERTAS purge
/
drop table AUX_G4389_IRIS_1 purge
/
drop table AUX_G4389_IRIS_2 purge
/
drop table AUX_G4389_IRIS_3 purge
/
drop table AUX_G4389_IRIS_4 purge
/
drop table AUX_G4389_IRIS_5 purge
/
drop table AUX_G4389_IRIS_6 purge
/
drop table AUX_G4389_IRIS_7 purge
/
drop table AUX_G4389_IRIS_8 purge
/
drop table AUX_G4389_IRIS_9 purge
/
drop table AUX_G4389_IRIS_10 purge
/
drop table AUX_G4389_IRIS_11 purge
/
drop table AUX_G4389_IRIS_12 purge
/
drop table AUX_G4389_IRIS_13 purge
/
drop table AUX_G4389_IRIS_14 purge
/
drop table AUX_G4389_IRIS_15 purge
/
drop table AUX_G4389_IRIS_16 purge
/
drop table AUX_G4389_IRIS_17 purge
/
drop table AUX_G4389_IRIS_18 purge
/
drop table AUX_G4389_IRIS_19 purge
/
drop table AUX_G4389_IRIS_20 purge
/
drop table AUX_G4389_IRIS_21 purge
/
drop table AUX_G4389_IRIS_22 purge
/
drop table AUX_G4389_IRIS_23 purge
/
drop table AUX_G4389_IRIS_24 purge
/
drop table AUX_G4389_IRIS_25 purge
/
drop table AUX_G4389_IRIS_26 purge
/
drop table AUX_G4389_IRIS_27 purge
/
drop table AUX_G4389_IRIS_28 purge
/
drop table AUX_G4389_IRIS_29 purge
/
drop table AUX_G4389_IRIS_30 purge
/
drop table AUX_G4389_IRIS_31 purge
/
drop table AUX_G4389_IRIS_32 purge
/
drop table AUX_G4389_IRIS_33 purge
/
drop table AUX_G4389_IRIS_34 purge
/
drop table AUX_G4389_IRIS_35 purge
/
drop table AUX_G4389_IRIS_36 purge
/
drop table AUX_G4389_IRIS_37 purge
/
drop table AUX_G4389_IRIS_38 purge
/
drop table AUX_G4389_IRIS_39 purge
/
select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') "Hora Fin" from dual
/