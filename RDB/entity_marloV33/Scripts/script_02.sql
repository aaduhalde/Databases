SELECT SYSDATE() TIME_START_MONITOR;
select user() user;
\! echo version: INSERT_DATA monitor_facts_ac_data_temp;
\! echo aaduhalde@outlook.es;
\! echo _____________________INSERT_DATA monitor_facts_ac_data_temp;
/* carga de tablas  TEMP*/

INSERT INTO monitor.monitor_facts_ac_data_temp
( name, datecreate, dateexpi , amount1, amount2, amount3, amount4, flag1, flag2, datepay)
	select 
	(select 'name' from dual),
    now(),
    now(),
    (select '100.05' from dual) fact_account_1234,
    (select '100.90' from dual) fact_account_1234,
    (select '100.10' from dual) fact_account_1234,
    (select '100.50' from dual) fact_account_1234,
    (select 'AA' from dual) flag_status, 
    (select 'BB' from dual) flag_status,
    now()
from 
    dual;



SELECT SYSDATE() TIME_FINISHED
\! echo _____________________INSERT_DATA monitor_facts_ac_data_temp ;
