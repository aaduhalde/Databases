Install ORACLE XE in linux whit DOCKER. 5.15.0-82-generic
  https://blogs.oracle.com/connect/post/deliver-oracle-database-18c-express-edition-in-containers 

 Install SQLplus on Linux
  
Step 1: Download the Basic Package (ZIP) by using the following command: 
     wget https://download.oracle.com/otn_software/linux/instantclient/214000/instantclient-basic-linux.x64-21.4.0.0.0dbru.zip 
  
Step 2: Download the SQL*Plus Package (ZIP) by using the following command: 
     wget https://download.oracle.com/otn_software/linux/instantclient/214000/instantclient-sqlplus-linux.x64-21.4.0.0.0dbru.zip  
  
Step 3: Make a new directory for the instant client. 
     sudo mkdir -p /opt/oracle 
  
Step 4: Unzip the Basic Package in the newly-created directory. 
     sudo unzip -d /opt/oracle instantclient-basic-linux.x64-21.4.0.0.0dbru.zip 
  
Step 5: Unzip the SQL *Plus Package in the newly-created directory. 
     sudo unzip -d /opt/oracle instantclient-sqlplus-linux.x64-21.4.0.0.0dbru.zip 
  
Step 6: List out the file contents of the newly-created directory. 
     cd /opt/oracle/instantclient_21_4 && find . -type f | sort 
  
Step 7: Set the LD_LIBRARY_PATH  in your ~/.bashrc source file. 
     export LD_LIBRARY_PATH=/opt/oracle/instantclient_21_4:$LD_LIBRARY_PATH 
  
Step 8: Set the PATH env vars in your ~/.bashrc 
     export PATH=$LD_LIBRARY_PATH:$PATH 
  
Step 9: Source your ~/.bashrc file 
     source ~/.bashrc 
  
Step 10: Run sqlplus -V command to confirm it’s installed or not. 
     sqlplus -V 
 
TNSNAMES, DBLINKS 
	 
sqlplus sys/yourpassword@//172.17.0.2:1521/XEPDB1 as sysdba 
 
Tnsnames.ora = 
 
XEPDB1 = 
  (DESCRIPTION = 
    (ADDRESS = (PROTOCOL = TCP)(HOST = 172.17.0.2)(PORT = 1521)) 
    (CONNECT_DATA = 
      (SERVER = DEDICATED) 
      (SERVICE_NAME = XEPDB1) 
    ) 
  ) 
