SELECT SYSDATE() TIME_START_MONITOR;
select user() user;
\! echo version: INSERT_monitor_facts_account1;
\! echo aaduhalde@outlook.es;
\! echo _____________________INSERT_monitor_facts_account1;
/* carga de tablas PROD*/

INSERT INTO monitor.monitor_facts_account1
( name, datecreate, dateexpi , amount1, amount2, amount3, amount4, flag1, flag2, datepay)
	select 
    name, 
    datecreate, 
    dateexpi, 
    amount1, 
    amount2, 
    amount3, 
    amount4, 
    flag1, 
    flag2, 
    datepay
     from  monitor.monitor_facts_ac1_data_temp;


SELECT SYSDATE() TIME_FINISHED
\! echo _____________________INSERT_monitor_facts_account1;


