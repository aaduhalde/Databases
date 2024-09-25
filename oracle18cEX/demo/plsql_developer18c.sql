
SET timing ON
SET verify OFF
SET SERVEROUTPUT ON SIZE 10000
WHENEVER SQLERROR EXIT ROLLBACK --CONTINUE
ALTER SESSION SET NLS_DATE_FORMAT='dd/mm/yyyy'
/



COLUMN USERNAME FORMAT a30
COLUMN DEFAULT_TABLESPACE FORMAT a20
SELECT USERNAME , DEFAULT_TABLESPACE from DBA_USERS
/


SELECT NAME FROM v$database;
/


PROMPT ********************************* * * * * * * Alejandro Adrian Duhalde


--Crear usuario en esquema XE
--Crear entidad para usuario esquema XE


