USE monitor;

LOAD DATA INFILE '/CSV/monitor_account1.csv'
INTO TABLE monitor_account1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/CSV/monitor_account2.csv'
INTO TABLE monitor_account2
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/CSV/monitor_assets1.csv'
INTO TABLE monitor_assets1 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/CSV/monitor_assets2.csv'
INTO TABLE monitor_assets2 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/CSV/monitor_assets3.csv'
INTO TABLE monitor_assets3
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/CSV/monitor_assets4.csv'
INTO TABLE monitor_assets4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/CSV/monitor_fixed_cost.csv'
INTO TABLE monitor_fixed_cost
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/CSV/monitor_prices.csv'
INTO TABLE monitor_prices
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/CSV/monitor_creditor.csv'
INTO TABLE monitor_creditor 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/CSV/monitor_facts_x1234.csv'
INTO TABLE monitor_facts_x1234
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/CSV/monitor_facts_account1.csv'
INTO TABLE monitor_facts_account1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/CSV/monitor_facts_account2.csv'
INTO TABLE monitor_facts_account2
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/CSV/monitor_facts_assets.csv'
INTO TABLE monitor_facts_assets
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/CSV/monitor_facts_creditor.csv'
INTO TABLE monitor_facts_creditor
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/CSV/monitor_facts_fidex_cost.csv'
INTO TABLE monitor_facts_fidex_cost
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

/*
SHOW GLOBAL VARIABLES LIKE 'local_infile';
mysql -u user -p --local-infile=1 YourDatabaseName

MariaDB stores values that use the DATETIME data type in a format that supports values between 
1000-01-01 00:00:00.000000 and 9999-12-31 23:59:59.999999.
*/