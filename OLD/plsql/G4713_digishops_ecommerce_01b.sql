PROMPT *********************************************************************
PROMPT  
PROMPT Archivo....: G4713_digishops_ecommerce_01a.sql
PROMPT
PROMPT Descripcion: DIGISHOPS_AUX1
PROMPT
PROMPT
PROMPT *********************************************************************
PROMPT Autor......: Alejandro Duhalde
PROMPT Reviso.....:
PROMPT Produccion.: DIGISHOPS
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
PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT Lectura de Parametros < < < 
PROMPT **********************************************************************

--TIEMPO INICIO
COLUMN val_0 new_value v_hora_inicio noprint
SELECT TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss') val_0
FROM DUAL
/

--ESQUEMA_USUARIO
COLUMN val1 new_value v_esquema_rac8_1    noprint
SELECT 'EXC44585' val1
FROM DUAL
/

--ESQUEMA_RAC8
COLUMN val11 new_value v_esquema_rac8_2    noprint
SELECT 'DRACING' val11
FROM DUAL
/

--origen_Catalogo
COLUMN val2 new_value v_path_origen    noprint
SELECT 'DUAL_DATA_IN' val2
FROM DUAL
/

--Destino_Catalogo
COLUMN val22 new_value v_path_destino    noprint
SELECT 'DIGISHOPS_AUX1' val22
FROM DUAL
/


PROMPT **********************************************************************
PROMPT ************************************     PARAMETROS EN PANTALLA  *****
PROMPT **********************************************************************
PROMPT Parametro: [TIEMPO INICIO]               - Valor: [&v_hora_inicio]
PROMPT Parametro: [ESQUEMA_USUARIO]             - Valor: [&v_esquema_rac8_1]
PROMPT Parametro: [ESQUEMA_RAC8]                - Valor: [&v_esquema_rac8_2]
PROMPT **********************************************************************
PROMPT Parametro: [origen_Catalogo]            - Valor: [&v_path_origen]
PROMPT Parametro: [Destino_Catalogo]           - Valor: [&v_path_destino]
PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT ************************************     ORIGEN  [&v_path_origen]
PROMPT **********************************************************************
DESCRIBE &v_esquema_rac8_1..&v_path_origen
/
PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT ************************************     DESTINO  [&v_path_destino]
PROMPT **********************************************************************

DESCRIBE &v_esquema_rac8_2..&v_path_destino
/

CREATE TABLE &v_path_destino AS
SELECT 
(
columna1 VARCHAR(100),
columna2 VARCHAR(100)
FROM (SELECT CONVERT('DATO1', CHAR) columna1, CONVERT('DATO2', CHAR) columna2 FROM DUAL;)
UNION ALL
columna3 VARCHAR(100),
columna4 VARCHAR(100)
FROM (SELECT CONVERT('DATO3', CHAR) columna1, CONVERT('DATO4', CHAR) columna2 FROM DUAL;)
)
/

PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT ************************************     LOGICA  [&v_path_origen]
PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT **********************************************************************
/












--TERMINA LOGICA
PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT **************************************** PROCESADOok
PROMPT **********************************************************************
PROMPT **********************************************************************
/

--TIEMPO FIN
COLUMN val_100 new_value v_hora_fin noprint
SELECT TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss') val_100
FROM DUAL
/

PROMPT ************************************************* &v_hora_inicio : inicio Script
PROMPT ************************************************* &v_hora_fin : fin Script
/

COMMIT
/
