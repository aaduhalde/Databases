USE monitor;

SELECT *
INTO OUTFILE '/CSV/monitor_account1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM monitor_account1;

SELECT *
INTO OUTFILE '/CSV/monitor_account2.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM monitor_account2;

SELECT *
INTO OUTFILE '/CSV/monitor_assets1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM monitor_assets1;

SELECT *
INTO OUTFILE '/CSV/monitor_assets2.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM monitor_assets2;

SELECT *
INTO OUTFILE '/CSV/monitor_assets3.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM monitor_assets3;

SELECT *
INTO OUTFILE '/CSV/monitor_assets4.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM monitor_assets4;

SELECT *
INTO OUTFILE '/CSV/monitor_creditor.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM monitor_creditor;

SELECT *
INTO OUTFILE '/CSV/monitor_prices.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM monitor_prices;

SELECT *
INTO OUTFILE '/CSV/monitor_fixed_cost.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM monitor_fixed_cost;

SELECT *
INTO OUTFILE '/CSV/monitor_facts_x1234.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM monitor_facts_x1234;

SELECT *
INTO OUTFILE '/CSV/monitor_facts_account1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM monitor_facts_account1;

SELECT *
INTO OUTFILE '/CSV/monitor_facts_account2.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM monitor_facts_account2;

SELECT *
INTO OUTFILE '/CSV/monitor_facts_assets.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM monitor_facts_assets;

SELECT *
INTO OUTFILE '/CSV/monitor_facts_creditor.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM monitor_facts_creditor;
