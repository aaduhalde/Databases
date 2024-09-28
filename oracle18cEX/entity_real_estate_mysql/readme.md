CREATE USER 'marloV33'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON * . * TO 'marloV33'@'localhost';
FLUSH PRIVILEGES;





ALL PRIVILEGES: tal como vimos antes, esto permitiría que un usuario MySQL accediera completamente a la base de datos designada (o si no se selecciona una base de datos en particular, el usuario tendría acceso a todo el sistema);
CREATE: les permite a los usuarios crear nuevas tablas o bases de datos;
DROP: les permite eliminar tablas o bases de datos;
DELETE: les permite eliminar filas de tablas;
INSERT: les permite insertar filas en tablas;
SELECT: les permite usar el comando SELECT para consultar información en bases de datos;
UPDATE: les permite actualizar filas en tablas;
GRANT OPTION: les permite otorgar o suprimir privilegios de otros usuarios de la manera que vimos anteriormente, esto le daría a un usuario MySQL todo el acceso a una base de datos designada (o si no se selecciona una base de datos en particular, a todo el sistema).
Para proporcionar un permiso específico a un usuario, puede usar la siguiente estructura:

GRANT [tipo de permiso] ON [nombre de la base de datos].[nombre de la tabla] TO '[nombredeusuario]'@'localhost';

REVOKE [tipo de permiso] ON [nombre de la base de datos].[nombre de la tabla] FROM '[nombredeusuario]'@'localhost';

DROP USER 'usuariodeejemplo'@'localhost';
quit

////////////////////////////////////////////////

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




///////////////////////////////




SELECT 
	amount1 as p,
	amount2 as u,
	datecreate as d
	FROM monitor.monitor_prices;

SELECT 	
	a.amount2 as u1, 
	b.amount2 as u2, 
	c.amount2 as u3, 
	d.amount2 as u4
	FROM 
	monitor.monitor_assets1 a,
	monitor.monitor_assets2 b,
	monitor.monitor_assets3 c,
	monitor.monitor_assets4 d;


/*Sum total to pay,
Proyect in 30 days, 20 days, for day, for hour, */

SELECT 
	(SELECT SUM(amount2) FROM monitor.monitor_account2) AS u1,
	(SELECT SUM(amount2) FROM monitor.monitor_fixed_cost) AS u2,
	(SELECT SUM(amount2) FROM monitor.monitor_account1) AS u3,
	(SELECT SUM(amount2) FROM monitor_creditor) AS u4,
	(SELECT SUM(amount2) FROM monitor.monitor_account2)+(SELECT SUM(amount2) FROM monitor.monitor_fixed_cost)+(SELECT SUM(amount2) FROM monitor.monitor_account1) as STOTAL,
	(((SELECT SUM(amount2) FROM monitor.monitor_account2)+(SELECT SUM(amount2) FROM monitor.monitor_fixed_cost)+(SELECT SUM(amount2) FROM monitor.monitor_account1))/20) as VAL_DAY2,
	(((SELECT SUM(amount2) FROM monitor.monitor_account2)+(SELECT SUM(amount2) FROM monitor.monitor_fixed_cost)+(SELECT SUM(amount2) FROM monitor.monitor_account1))/30) as VAL_DAY3,
	(((SELECT SUM(amount2) FROM monitor.monitor_account2)+(SELECT SUM(amount2) FROM monitor.monitor_fixed_cost)+(SELECT SUM(amount2) FROM monitor.monitor_account1))/80) as VAL_HOUR80,
	(SELECT SUM(amount2) FROM monitor.monitor_account2)+(SELECT SUM(amount2) FROM monitor.monitor_fixed_cost)+(SELECT SUM(amount2) FROM monitor.monitor_account1)+(SELECT SUM(amount2) FROM monitor_creditor) as TOTAL
	FROM DUAL; 
	
////////////////////////////////

/*TO PAY FIRST*/
SELECT SUM(amount2) FROM monitor.monitor_account2;
/*TO PAY SECOND*/
SELECT SUM(amount2) FROM monitor.monitor_fixed_cost;
/*TO PAY THIRD*/
SELECT SUM(amount2) FROM monitor.monitor_account1;
/*TO PAY FOURTH*/
	SELECT SUM(amount2) FROM monitor_creditor;

/*API REST PYTHON, MARIADB PRICES DAILY*/
SELECT * FROM monitor.monitor_prices;


/*FACTS EVOLUTION ASSETS FOR MOUNTH*/
SELECT * FROM monitor.monitor_facts_assets;
	SELECT  SUM(amount1), SUM(amount2) FROM monitor.monitor_facts_assets;
	/*MVC*/

/*FACTS EVOLUTION FIXED COST FOR MOUNTH*/
SELECT * FROM monitor.monitor_facts_fidex_cost;
	SELECT SUM(amount2) FROM monitor.monitor_fixed_cost;
	/*MVC*/	

/*FACTS EVOLUTION CREDITOR FOR MOUNTH*/
SELECT * FROM monitor_facts_creditor;
	SELECT * FROM monitor_creditor;
	SELECT SUM(amount2) FROM monitor_creditor;
	/*MVC*/

/*FACTS EVOLUTION ACCOUNT1 FOR MOUNTH*/
SELECT * FROM monitor.monitor_facts_account1;
	SELECT * FROM monitor.monitor_account1;
	/*MVC*/

/*FACTS EVOLUTION ACCOUNT2 FOR MOUNTH*/
SELECT * FROM monitor.monitor_facts_account2;
	SELECT * FROM monitor.monitor_account2;
	/*MVC*/

/*FACTS EVOLUTION X1234 FOR MOUNTH*/
SELECT * FROM monitor.monitor_facts_x1234;
	/*MVC*/


/*ROI1a in function of the investment 1a*/
/*ROI1n in function of the investment 1n*/
/*El rendimiento o retorno sobre la inversión es una razón financiera que compara 
el beneficio o la utilidad obtenida en relación con la inversión realizada,*/
/*ACTIVES*/
/*furniture*/
/*not furniture*/

/*
OLTP, bases de datos, procesamiento de transacciones en línea, DATOS EN TIEMPO REAL  
OLAP, procesamiento analítico, HISTORICO DE DATOS. (cubos multidimensionales)  

DATAWAREHOUSE. Almacén de datos (EDW), aplicaciones, es una base de datos orientada al análisis de informacion, 
se olvida de las transacciones. 
DATAMARTS. Bases de datos departamentales, que se alimentan del datawarehouse, 
con el fin de evitar una búsqueda extensiva del datawarehouse por parte del sistema 
y así recibir la informacion más rápido.  

1NF: Elimina duplicados y crea tablas separadas para grupos de datos relacionados.  
2NF: Elimina subgrupos de datos en múltiples filas de una tabla y crea tablas nuevas, con relaciones entre ellas.  
3NF: Elimina columnas que no dependen de la clave principal. 

Cardinalidad, UML:  
De uno a uno, es cuando uno se puede relacionar solo con un elemento.  
De uno a mucho, es cuando se puede relación con varios elementos.  
De muchos a muchos, es cuando dos o más elementos de una entidad se pueden relación con dos o más elementos.  
De uno a cero o muchos, es cuando un elemento se relaciona con ninguno o muchos elementos de otra.  
De muchos a cero o muchos, es cuando muchos elementos de una tabla se relacionan con ninguno o muchos elementos de otra.  

Construcción DE UN MODELO RELACIONAL, concebir toda su lógica de operación. Teniendo en claro la situación del negocio y todos sus procesos, clientes, empleados, productos, tiendas, clientes divididos por grupos de clientes, proveedores, cada producto en una categoría. 

1. Define todas la entidad y tablas necesarias no te centres en los atributos. 
2. Estable sus relaciones y pon su cardinalidad. 
3. Normaliza hasta la tercera forma normal, con esto todas las tablas tendrán una llave primaria, mantendrán dependencia funcional y no contendrán duplicación de datos. 
4. Elige atributos, no almacenes datos que pueden inferir de otros. Por ej, la edad se puede inferir de la fecha de nacimiento. 
5. Tabla cruzada "muchos a muchos" "a muchos o cero", 

Es mejor construir entre ellas una tabla cruzada. 
Las tablas cruzadas se usan cuando existe una relación de muchos a muchos, YA QUE, SI UNES LA TABLA CON UNA LLAVE FORANEA, tendría inconsistencias. 

#Esquema ESTRELLA: el mas simple.  
Tabla de HECHOS la central, está rodeada de entidades llamadas dimensiones y lleva lógica relacional en que las tablas de hechos recaen en la segunda forma normal. Hace posible que la programación de la consulta sea más simple y rápida. Solo existe una tabla de dimensiones por dimensión. 
¿Cuántos productos se vendieron?  
¿Quién vendió cada uno?  
¿Quién compro cada uno?  
¿Cuándo ocurrió?  
   

#Esquema de copo de nieve. 
Está diseñado para el mantenimiento de dimensiones, parecido con un modelo relacional ya que cumple con la tercera forma normal. Trata de segmentar informacion en caso de que esta sea muy extensa, ahorra espacio en memoria, para tablas de muchos registros, segmentar por grupos las tablas, de esta manera no usamos una misma tabla para misma consulta y segmentamos la carga de cómputo en memoria. 

#Esquema constelación. 
Existe más de una tabla de hechos, así las tablas de dimensiones pueden estar repartidas entre las múltiples tablas de hechos, con el fin de tener diferentes aspectos del negocio registrado.  

VENTAS POR MES 
PRODUCTO MAS VENDIDO 
EMPLEADO DEL MES 
BONO DE EMPLEO 

 La gran ventaja de este tipo de esquemas es su gran flexibilidad, pero al generarla se sacrifica su facilidad y pueden ser difíciles de mantener en un futuro por el crecimiento de los datos, logra la misma velocidad de búsqueda que el esquema estrella, siempre y cuando se genere una tabla por dimensión.   
 ¿Bono por mes para cada empleado en cada uno de los territorios? Con esto sabrá el rendimiento de cada empleado,  

SOLUCION= tomar el esquema estrella y agregar otra tabla de hechos, en esta crea llaves primerias de las dimensiones de tiempo, producto y empleado. Además, crea la dimensión geográfica para conocer el territorio de donde proviene el empleado. La segunda tabla de hechos se llamará BONOS POR EMPLEADO y resolverá este aspecto del negocio. 
*/
