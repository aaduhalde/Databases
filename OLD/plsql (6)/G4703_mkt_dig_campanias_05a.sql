PROMPT *********************************************************************
PROMPT  DROPS G4703
PROMPT *********************************************************************
PROMPT Archivo....: G4703_mkt_dig_campanias_05a.sql
PROMPT Autor......: Alejandro Duhalde
PROMPT Reviso.....:
PROMPT Produccion.:
PROMPT Descripcion: DROPS G4703
PROMPT 01/02/2023   Alejandro Duhalde      Creacion del script
PROMPT *********************************************************************
PROMPT *********************************************************************
PROMPT Seteos Iniciales
PROMPT *********************************************************************
SET timing ON
SET verify OFF
SET SERVEROUTPUT ON SIZE 10000
WHENEVER SQLERROR CONTINUE
ALTER SESSION SET NLS_DATE_FORMAT='dd/mm/yyyy'
/
--TIEMPO INICIO
COLUMN val_0 new_value v_hora_inicio noprint
SELECT TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss') val_0
FROM DUAL
/


PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT Lectura de Parametros < < <
PROMPT **********************************************************************
COLUMN val1 new_value v_esquema_rac8_1    noprint
SELECT 'EXC44585.' val1
FROM DUAL
/

COLUMN val2 new_value v_path_origen    noprint
SELECT '/exa1desa/desa/G4703/' val2
FROM DUAL
/

PROMPT **********************************************************************
PROMPT Parametro: [ESQUEMA_RAC8_1_DATAIN_1]    - Valor: [&v_esquema_rac8_1]
PROMPT Parametro: [origen_Catalogo]            - Valor: [&v_path_origen]
PROMPT **********************************************************************
/

PROMPT *** IMPUT_DATA     ***************************************************
!ls &v_path_origen| grep \.csv$

PROMPT **********************************************************************
PROMPT **********************************************************************
/

!chmod 777 &v_path_origen*.*
!rm &v_path_origen*.ctl
!rm &v_path_origen*.md5_
!rm &v_path_origen*.log
!rm &v_path_origen*.bad

PROMPT **********************************************************************
PROMPT Borrando archivos temporales 
PROMPT ******************************* ******** ********** ***** **
PROMPT **********************************************************************
PROMPT ******************************************************************* ok
/


--BORRADO DE TABLAS AUXILIARES
DROP TABLE &v_esquema_rac8_1.aux1_mkt_dig_G4703 PURGE
/
COMMIT
/

--tiempo fin
COLUMN val_100 new_value v_hora_fin noprint
SELECT TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss') val_100
FROM DUAL
/
PROMPT ************************************************* &v_hora_inicio : inicio Script
/
PROMPT ************************************************* &v_hora_fin : fin Script
/
