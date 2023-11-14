CREATE  TABLE monitor.monitor_account1 ( 
	idac1                INT  NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
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

CREATE  TABLE monitor.monitor_account2 ( 
	idac2                INT  NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
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
 ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE  TABLE monitor.monitor_assets ( 
	idassets             INT  NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
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
 ) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

 CREATE  TABLE monitor.monitor_assets2 ( 
	idassets2             INT  NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
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
 ) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

 CREATE  TABLE monitor.monitor_assets3 ( 
	idassets3             INT  NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
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
 ) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

 CREATE  TABLE monitor.monitor_assets4 ( 
	idassets4             INT  NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
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
 ) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE  TABLE monitor.monitor_creditor ( 
	idcreditor           INT  NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
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
 ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE  TABLE monitor.monitor_facts_x1234 ( 
	idx1234              INT  NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
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
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

 CREATE  TABLE monitor.monitor_facts_fidex_cost ( 
	idfixcost                INT  NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
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

  CREATE  TABLE monitor.monitor_facts_creditor ( 
	idxcredtr              INT  NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
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
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

   CREATE  TABLE monitor.monitor_facts_account1 ( 
	idxacc1              INT  NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
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
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

    CREATE  TABLE monitor.monitor_facts_account2 ( 
	idxacc2              INT  NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
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
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE  TABLE monitor.monitor_fixed_cost ( 
	idfc                 INT  NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
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
 ) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE  TABLE monitor.monitor_facts__assets ( 
	idac1                INT  NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
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

CREATE  TABLE monitor.monitor_prices ( 
	idprices             INT  NOT NULL   AUTO_INCREMENT  PRIMARY KEY,
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
 ) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
