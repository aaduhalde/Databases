#!/bin/bash
#Event-driven programming

user=root
password='password'
mysql -h 127.0.0.1 -P 3306 -u $user monitor -p$password < /home/path.sql