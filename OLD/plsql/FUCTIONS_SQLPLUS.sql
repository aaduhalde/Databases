--0DICSYS_DESA\8_G4713\FUCTIONS_SQLPLUS.sql
--C:\xampp\htdocs\0DICSYS_DESA\8_G4713\FUCTIONS_SQLPLUS.sql
cl scr
SET timing ON
SET verify OFF
SET SERVEROUTPUT ON SIZE 10000
WHENEVER SQLERROR CONTINUE 
--EXIT ROLLBACK
ALTER SESSION SET NLS_DATE_FORMAT='dd/mm/yyyy'
/

--VARIABLES =
COLUMN val1 new_value DATA_iN_1a    noprint
SELECT 'DEPARTMENTS' val1
FROM DUAL
/

COLUMN val1 new_value DATA_iN_2a    noprint
SELECT 'HR' val1
FROM DUAL
/

PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT
PROMPT Parametro1: [DATA_iN_1a]             - Valor1: [&DATA_iN_1a]
PROMPT Parametro2: [DATA_iN_2a]             - Valor2: [&DATA_iN_2a]
PROMPT Parametro3: [DATA_iN_3a]             - Valor3: [OFF_DATA_iN_3a] -- cantidad de columnas
PROMPT Parametro4: [DATA_iN_1b]             - Valor4: [OFF_DATA_iN_1b] -- atributo de campo
PROMPT Parametro5: [DATA_iN_2b]             - Valor5: [OFF_DATA_iN_2b] -- nombre_de_columna iniciai
PROMPT Parametro6: [DATA_iN_3b]             - Valor6: [OFF_DATA_iN_3c] -- output script insert, drop, export csv, export JSON. XML 
PROMPT
PROMPT **********************************************************************
PROMPT **********************************************************************
DESCRIBE &DATA_iN_1a
/

PROMPT **********************************************************************
PROMPT ****** ***************            REVISION DE PERMISOS:  
PROMPT **********************************************************************
--USAR MI ORACLE EXPRESS COMO DBA,
--CREAR UN ESQUEMA NUEVO, CON TODOS LOS PERMISOS DE ADMINISTRADOR 

COLUMN USERNAME FORMAT a10
COLUMN PRIVILEGE FORMAT a20
COLUMN ADMIN_OPTION FORMAT a10
select USERNAME, ADMIN_OPTION, PRIVILEGE
from user_sys_privs 
/
lv
-- sqlplus /nolog
-- connect / as sysdba
--ALTER USER sys IDENTIFIED BY "Password";
COLUMN USERNAME FORMAT a10
COLUMN USER_ID FORMAT a10
COLUMN CREATED FORMAT a10
select USERNAME, USER_ID, CREATED 
from all_users

PROMPT **********************************************************************
PROMPT **************************            EJECUCION:  ********************
PROMPT **********************************************************************
PROMPT **********************************************************************
--DROP TABLE &DATA_iN_1a PURGE;






PROMPT **********************************************************************
PROMPT **********************************************************************
PROMPT *************************   CATALOGO DE USUARIO:   *******************
PROMPT **********************************************************************
PROMPT **********************************************************************
SELECT * FROM CAT
/


COMMIT
/