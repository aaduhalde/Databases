PROMPT *********************************************************************
PROMPT  
PROMPT               Archivo....: 
PROMPT
PROMPT               Descripcion:
PROMPT
PROMPT
PROMPT *********************************************************************
PROMPT Autor......: Alejandro Duhalde
PROMPT Reviso.....:
PROMPT Produccion.:
PROMPT  
PROMPT *********************************************************************
PROMPT Seteos Iniciales
PROMPT *********************************************************************

SET timing ON
SET verify OFF
SET SERVEROUTPUT ON SIZE 10000
WHENEVER SQLERROR EXIT ROLLBACK --CONTINUE
ALTER SESSION SET NLS_DATE_FORMAT='dd/mm/yyyy'
/

--PARAMETROS
PROMPT **********************************************************************
PROMPT Lectura de Parametros < < < 
PROMPT **********************************************************************
/
--TIEMPO INICIO
COLUMN val_0 new_value v_hora_inicio noprint
SELECT TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss') val_0
FROM DUAL
/

COLUMN val1 new_value v_esquema_rac8_1    noprint
SELECT 'EXC44585' val1
FROM DUAL
/

COLUMN val2 new_value v_path_origen    noprint
SELECT '/exa1desa/desa/G4704/' val2
FROM DUAL
/

/*
PROMPT *** IMPUT_DATA     ***************************************************
!ls &v_path_origen| grep \.csv$

PROMPT **********************************************************************
PROMPT ******************************   Borrando archivos temporales 
PROMPT **********************************************************************
/
!chmod 777 &v_path_origen*.*
!rm &v_path_origen*.ctl
!rm &v_path_origen*.md5_
!rm &v_path_origen*.log
!rm &v_path_origen*.bad

PROMPT **********************************************************************
PROMPT ******************************* ******** ********** ***** **
PROMPT **********************************************************************
PROMPT ******************************************************************* ok
/
*/

PROMPT **********************************************************************
PROMPT ************************************PARAMETROS EN PANTALLA      ******
PROMPT **********************************************************************
PROMPT Parametro: [TIEMPO INICIO]              - Valor: [&v_hora_inicio]
PROMPT Parametro: [ESQUEMA_RAC8_1_DATAIN_1]    - Valor: [&v_esquema_rac8_1]
PROMPT Parametro: [origen_Catalogo]            - Valor: [&v_path_origen]
PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT **********************************************************************
/
--INICIA LOGICA


DROP TABLE DIGISHOPS_AUX1 PURGE
/

DROP TABLE DIGISHOPS_AUX2 PURGE
/

DROP TABLE DIGISHOPS_AUX3 PURGE
/




--TERMINA LOGICA
--TIEMPO FIN
COLUMN val_100 new_value v_hora_fin noprint
SELECT TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss') val_100
FROM DUAL
/
-- TERMINA LOGICA
PROMPT ************************************************* &v_hora_inicio : inicio Script
/
PROMPT ************************************************* &v_hora_fin : fin Script
/

COMMIT
/
