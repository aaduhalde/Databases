
SET timing ON
SET verify OFF
SET SERVEROUTPUT ON SIZE 10000
WHENEVER SQLERROR EXIT ROLLBACK --CONTINUE
ALTER SESSION SET NLS_DATE_FORMAT='dd/mm/yyyy'
/


PROMPT ************************************** RUN IN LOCALHOST
PROMPT **********************************************************************
PROMPT **************************************     REVISION DE PERMISOS :  

COLUMN val1 new_value v_esquema_rac8_1    noprint
SELECT 'EXC44585' val1
FROM DUAL
/

PROMPT Parametro: [ESQUEMA_USUARIO]             - Valor: [&v_esquema_rac8_1]



PROMPT **********************************************************************
PROMPT ************************************                  USER_SYS_PRIVS  
PROMPT **********************************************************************
COLUMN USERNAME FORMAT a8
COLUMN PRIVILEGE FORMAT a25
COLUMN ADMIN_OPTION FORMAT a5
COLUMN COMMON FORMAT a6
select USERNAME, ADMIN_OPTION, COMMON
from user_sys_privs 
/

PROMPT **********************************************************************
PROMPT ************************************                      DBA_USERS  
PROMPT **********************************************************************
COLUMN USERNAME FORMAT a8
COLUMN DEFAULT_TABLESPACE FORMAT a15
COLUMN PROFILE FORMAT a8
select USERNAME, DEFAULT_TABLESPACE, PROFILE  
from dba_users
where USERNAME = '&v_esquema_rac8_1'
/

PROMPT **********************************************************************
PROMPT ************************************                 USER_TABLESPACES  
PROMPT **********************************************************************
COLUMN TABLESPACE_NAME FORMAT a15
COLUMN STATUS FORMAT a8
SELECT TABLESPACE_NAME, STATUS 
FROM user_tablespaces
/

PROMPT **********************************************************************
PROMPT ************************************                    DBA_TAB_PRIVS  
PROMPT **********************************************************************
COLUMN GRANTEE FORMAT a10
COLUMN OWNER FORMAT a5
COLUMN TABLE_NAME FORMAT a30
COLUMN GRANTOR FORMAT a3
COLUMN PRIVILEGE FORMAT a6 
select GRANTEE, OWNER, TABLE_NAME, GRANTOR, PRIVILEGE 
from dba_tab_privs
where GRANTEE = '&v_esquema_rac8_1'
/

select TABLE_NAME from user_tables
/


COMMIT
/
