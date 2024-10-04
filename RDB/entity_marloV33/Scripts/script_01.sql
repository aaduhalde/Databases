SELECT SYSDATE() TIME_START_MONITOR;
select user() user;
\! echo version: create_monitor_facts_ac_data_temp;
\! echo aaduhalde@outlook.es;
\! echo _____________________create_monitor_facts_ac_data_temp;
/*CREATE */

CREATE  TABLE monitor.monitor_facts_ac_data_temp ( 
	iddata_temp          INT  NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
	name                 VARCHAR(100)  NOT NULL     ,
	datecreate           DATETIME  NOT NULL     ,
	dateexpi             DATETIME  NOT NULL     ,
	amount1              DECIMAL(20,2)  NOT NULL     ,
	amount2              DECIMAL(20,2)       ,
	amount3              DECIMAL(20,2)       ,
	amount4              DECIMAL(20,2)       ,
	flag1                VARCHAR(2)  NOT NULL     ,
	flag2                VARCHAR(2)       ,
	datepay              DATETIME       
 ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SELECT SYSDATE() TIME_FINISHED
\! echo _____________________create_monitor_facts_ac_data_temp;
