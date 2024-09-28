#!/bin/bash
#Event-driven programming
user=marloV33
password=`cat /home/alex/GIT/potential-invention/passmysql.txt`
mysql -h 127.0.0.1 -P 3306 -u $user monitor -p$password < /home/alex/GIT/Databases/oracle18cEX/entity_real_estate_mysql/Scripts/test.sql
