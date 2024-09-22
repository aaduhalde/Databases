PROMPT *********************************************************************
PROMPT  aux1_mkt_dig_G4703
PROMPT *********************************************************************
PROMPT Archivo....: G4703_mkt_dig_campanias_01a.sql
PROMPT Autor......: Alejandro Duhalde
PROMPT Reviso.....:
PROMPT Produccion.:
PROMPT Descripcion: Creacion de la tabla aux1_mkt_dig_G4703
PROMPT *********************************************************************
PROMPT Seteos Iniciales
PROMPT *********************************************************************
SET timing ON
SET verify OFF
SET SERVEROUTPUT ON SIZE 10000
WHENEVER SQLERROR EXIT ROLLBACK
ALTER SESSION SET NLS_DATE_FORMAT='dd/mm/yyyy'
/
--TIEMPO INICIO
COLUMN val_0 new_value v_hora_inicio noprint
SELECT TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss') val_0
FROM DUAL
/





--PARAMETROS
PROMPT **********************************************************************
PROMPT Lectura de Parametros
PROMPT **********************************************************************

COLUMN val1 new_value v_esquema_rac8    noprint
SELECT 'EXC44585.' val1
FROM DUAL
/

COLUMN val2 new_value archivo_origen    noprint
SELECT 'sf_mkt_dig_campanias.csv' val2
FROM DUAL
/

COLUMN val3 new_value espacio_tabla   noprint
SELECT 'DEVELOP_AUX' val3
FROM DUAL
/

COLUMN val4 new_value directorio   noprint
SELECT 'D_D_G4703_SF_MKT_DIG_CAMPA' val4
FROM DUAL
/

COLUMN val5 new_value v_path_origen    noprint
SELECT '/exa1desa/desa/G4703/' val5
FROM DUAL
/


PROMPT **********************************************************************
PROMPT Parametro: [ESQUEMA_RAC8]    - Valor: [&v_esquema_rac8]
PROMPT Parametro: [ARCHIVO ORIGEN]  - Valor: [&archivo_origen]
PROMPT Parametro: [espacio_tabla]   - Valor: [&espacio_tabla]
PROMPT Parametro: [directorio]      - Valor: [&directorio]
PROMPT Parametro: [origen_Catalogo] - Valor: [&v_path_origen]
/

CREATE TABLE &v_esquema_rac8.aux1_mkt_dig_G4703
( 

)
ORGANIZATION EXTERNAL
(TYPE ORACLE_LOADER
DEFAULT DIRECTORY &directorio
ACCESS PARAMETERS
(RECORDS DELIMITED BY NEWLINE
FIELDS TERMINATED BY ','
)
LOCATION ('&archivo_origen')
)
REJECT LIMIT UNLIMITED
/

COMMIT
/

--TIEMPO FIN
COLUMN val_100 new_value v_hora_fin noprint
SELECT TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss') val_100
FROM DUAL
/

PROMPT ************************************************* &v_hora_inicio : inicio Script
/
PROMPT ************************************************* &v_hora_fin : fin Script
/
