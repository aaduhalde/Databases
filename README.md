# Databases NoSQL vs SQL
# BIGDATA

 Development, architecture and scalability of data models.
  ISO security information policies
  
  >datalakes
  >apis
  >datawarehouses
  >datamarts 
  
  
  TEST
  #Unit 
  #integration 
  #a/b
  
  Manipulaci�n, integraci�n de datos y automatizaci�n.  
  Machine learning. REST API e interfaces de usuario. CI/CD Pipelines. 

  Data governance, data security, and privacy practices, including data anonymization, access controls, and compliance regulations

TDD, BDD.
Development, architecture and scalability of data models.

(RGPD, CCPA). 

El RGPD se centra en la creación de un marco legal de “privacidad por defecto” para la UE en su totalidad, mientras que la CCPA pretende crear transparencia en el enorme negocio de datos y el derecho de sus consumidores.

Donde el RGPD crea una puerta para que el usuario de la UE pueda bloquear cualquier procesamiento de datos previo al consentimiento, la CCPA crea una ventana al consumidor para averiguar qué datos de los suyos han sido recogidos por negocios o terceras partes.

Donde el RGPD exige a las webs, compañías y negocios tener unas bases legales para el procesamiento (en inglés) de datos personales en la UE (de los cuáles la primera base legal es el consentimiento), la CCPA no tiene un marco de actuación parecido.

De hecho, de acuerdo con la CCPA, un negocio no necesita el consentimiento previo del usuario antes de procesar sus datos, ni una web necesita el consentimiento previo del mismo para vender sus datos a terceras partes.

Escalabilidad 

 Es un anglicismo que describe la capacidad de un negocio o sistema de crecer en magnitud. Aunque la palabra escalabilidad no existe en el diccionario de la RAE el adjetivo más cercano ampliable es de poco uso en telecomunicaciones y en ingeniería informática. 

 La escalabilidad, termino tomado en préstamo del idioma inglés, es la propiedad deseable de un sistema, una red o un proceso, que indica su habilidad para reaccionar y adaptarse sin perder calidad, o bien manejar el crecimiento continuo de trabajo de manera fluida, o bien para estar preparado para hacerse más grande sin perder calidad en los servicios ofrecidos. 

En general, también se podrá definir como la capacidad del sistema informático de cambiar su tamaño o configuración para adaptarse a las circunstancias cambiantes. 

Por ejemplo, una Universidad que establece una red de usuarios por Internet para un edificio de docentes y no solamente quiere que su sistema informático tenga capacidad para acoger a los actuales clientes que son todos profesores, sino también a los clientes que pueda tener en el futuro dado que hay profesores visitantes que requieren de la red por algunas aplicaciones académicas, para esto es necesario implementar soluciones que permitan el crecimiento de la red sin que la posibilidad de su uso y reutilización disminuya o que pueda cambiar su configuración si es necesario. 

La escalabilidad como propiedad de los sistemas es generalmente difícil de definir, en particular es necesario definir los requisitos específicos para la escalabilidad en esas dimensiones donde se crea que son importantes. 

Es una edición altamente significativa en sistemas electrónicos, bases de datos, ruteadores y redes.  A un sistema cuyo rendimiento es mejorado después de haberle añadido más capacidad hardware, proporcionalmente a la capacidad añadida, se dice que pasa a ser un sistema escalable. 

Bases de datos: Es el proceso por el cual se redistribuyen adecuadamente los atributos entre entidades, para evitar inconsistencias. Es el proceso por el cual se aplican reglas para pulir un modelo relacional. 

MODELO RELACIONAL 

Es la estructura de la mayoría de la DB actualmente, basa su lógica en las relaciones, su construcción se deriva del modelo entidad, relación. Construcción de una tabla con atributos, llaves primarias, llaves foráneas. 

#FORMAS NORMALES proporcionan los criterios para determinar el grado de vulnerabilidad de una tabla a inconsistencias y anomalías lógicas. Cuanto más alta sea la forma normal aplicable a una tabla, menos vulnerable será a inconsistencias y anomalías. Cada tabla tiene una «forma normal más alta» 

1NF – 2NF – 3NF – BCNF – 4NF – 5NF – DKNF – 6NF – Denormalización  

 (HNF): por definición, una tabla siempre satisface los requisitos de su HNF y de todas las formas normales más bajas que su HNF; también por definición, una tabla no puede satisfacer los requisitos de ninguna forma normal más arriba que su HNF. 

1NF: Elimina duplicados y crea tablas separadas para grupos de datos relacionados. 

2NF: Elimina subgrupos de datos en múltiples filas de una tabla y crea tablas nuevas, con relaciones entre ellas. 

3NF: Elimina columnas que no dependen de la clave principal. 

La BCNF es una versión más estricta de la 3NF. Una relación está en BCNF si y solo si cada dependencia funcional X -> Y implica que X es una superclave. En otras palabras, la relación no tiene dependencias funcionales no triviales donde el determinante no es una superclave. 

MODELO RELACIONALES, ESQUEMAS. Datos estructurados.  

OLTP, bases de datos, procesamiento de transacciones en línea, DATOS EN TIEMPO REAL 

OLAP, procesamiento analítico, HISTORICO DE DATOS. (cubos multidimensionales) 

Tipos de modelos OLAP. ¿Tabular o Multidimensional? diferencia entre OLTP y OLAP, y en esta ocasión vamos a hacer los propios desglosando los tipos que podemos encontrar dentro del modelo OLAP. Los modelos OLAP tienen como principal característica que cumplir FASMI (Fast Analysis of Shared Multidimensional Information) y en este orden: 

Fast: el sistema tiene que entregar la mayor cantidad de datos en el menor tiempo posible en aproximadamente 5 segundos. Para el análisis básico y elemental, no debe tardar más de 1 segundo y pocas veces puede llegar a ascender a 20 segundos. 

Analysis: lógica de negocio relevante y análisis de información que se simple para los analistas de negocio no expertos. 

Shared: poder gestionar múltiples actualizaciones de forma segura y rápida. 

 Multidimensional: requisito básico, el sistema resultado debe proporcionar una vista conceptual multidimensional de los datos, es decir, podemos combinar dimensiones para obtener el resultado (valor) buscado. 

 Information: el sistema debe contener todos los datos necesarios para las aplicaciones. 

Modelo Multidimensional 

Dentro del Modelo Multidimensional hay que diferenciar entre diferentes tipos en función de la arquitectura de almacenamiento por: 

ROLAP (Relational Online Analytical Processing). Almacena las agregaciones en datos relacionales indexados junto con los datos origen. No utiliza almacenamiento multidimensional, por lo que los datos ROLAP son más lentos para consultar y procesar que MOLAP o HOLAP, pero permite el acceso en tiempo real (Direct Query) a los datos y utiliza menos espacio de almacenamiento. Con esta arquitectura no necesitaríamos procesar/implementar de nuevo el proyecto de SSAS. ROLAP podría crear vistas indexadas para el acceso a la información. 

MOLAP (Multidimensional Online Analytical Processing). MOLAP es el modo de almacenamiento más utilizado. Almacena tanto las agregaciones como una copia de los datos del origen (normalmente del Data Warehouse) en el cubo multidimensional. Se podría parar el Data Warehouse. MOLAP ofrece el mayor rendimiento, pero requiere más espacio de almacenamiento debido a dicha duplicación. Hay latencia cuando se usa el almacenamiento MOLAP porque los datos del cubo se actualizan solo cuando se procesa el cubo, por lo que los cambios desde el origen de datos solo se actualizan periódicamente. Podemos usar el almacenamiento en caché proactivo con MOLAP. Podemos utilizar un almacenamiento en caché proactivo, que notifica al servidor cuando se realizan cambios en la fuente de datos y que luego se incorporan. Mientras la caché se reconstruye con nuevos datos, podríamos optar por enviar consultas a los datos por ROLAP, que están actualizados, pero son más lentos o bien al almacenamiento MOLAP original, que es más rápido, pero no tendríamos los nuevos datos hasta que se procesase de nuevo. 

Normalmente, las actualizaciones serían diarias. Lo normal es programar la incorporación de nuevos datos en el Data Wharehouse por la noche y justo después procesar el cubo MOLAP. Sin embargo, algunos sistemas están en uso las 24/7. Para obtener el máximo rendimiento. Cuando se actualizan los objetos, se requerirá algún tiempo de inactividad. Esto se podría procesando el cubo en un servidor intermedio y utilizando la sincronización de la base de datos para copiar los datos procesados en el servidor de producción. 

HOLAP (Hybrid Online Analytical Processing). Este almacenamiento es un híbrido entre el MOLAP y el ROLAP. En este modo almacena las agregaciones en el cubo multidimensional y deja los datos de origen en la base de datos relacional. Esta puede ser una buena solución cuando rara vez se accede a los datos. Si se accede con frecuencia a los datos, MOLAP proporcionaría un rendimiento mejorado. 

Las principales ventajas entre el modelo tabular y el modelo multidimensional son: 

El modelo relacional sobre el que se diseña el modelo tabular es ampliamente comprendido e intuitivo por lo que la barrera de aprendizaje es mucho más rápida para los desarrolladores. De esta forma, los costes de proyecto son menores. 

El diseño de los modelos tabulares generalmente es más simple que los modelos multidimensionales, por lo que el tiempo de implementación de los proyectos es más rápido. 

 El modelo tabular utiliza el lenguaje DAX al igual que Power BI y los modelos multidimensionales MDX. 

 Características de rendimiento: 

  Modelo Tabular: 

 + memoria y – disco 

 Muchos más Data Sources que el modelo multidimensional 

 Tendencia del mercado 

  Modelo Multidimensional: 

 + disco y – memoria 

 En desuso para proyecto nuevos 



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

5. Tabla cruzada «muchos a muchos» «a muchos o cero», 

Es mejor construir entre ellas una tabla cruzada. 

Las tablas cruzadas se usan cuando existe una relación de muchos a muchos, YA QUE, SI UNES LA TABLA CON UNA LLAVE FORANEA, tendría inconsistencias. 

una venta puede tener muchos productos. 

un producto puede tener muchas ventas. 



Diseño y operación:  

DATAWAREHOUSE. Almacén de datos (EDW), aplicaciones, es una base de datos orientada al análisis de informacion, se olvida de las transacciones. 

DATAMARTS. Bases de datos departamentales, que se alimentan del datawarehouse, con el fin de evitar una búsqueda extensiva del datawarehouse por parte del sistema y así recibir la informacion más rápido. 

TRANSACCIONES 

Es un conjunto de ordenes que se ejecutan formando una unidad indivisible de trabajo, lo que significa que el proceso no se puede ser detenido ni dejado a medias. Si empieza debe terminar. Si por alguna causa el sistema cancela la transacción esta deshará las ordenes ejecutas hasta dejar la base en su estado inicial, para cumplir con esto todas las transacciones deben cumplir con: 

A C I D, características de los parámetros que permiten clasificar las transacciones de los sistemas de gestión de bases de datos. 

Atomicidad, asegura que la operación se realice en su totalidad o que no se inicie. 

Consistencia, asegura que solo empieza aquello que se puede acabar. 

Aislamiento, asegura que una operación no puede afectar a otras. 

Durabilidad, asegura que una vez realizada la operación esta persistirá y no se podrá deshacer, aunque falle el sistema. 

BEGIN TRANSACTION, inicio. 

 COMMIT, completada con éxito 

 ROLLBACK, indica que se ha presentado un fallo y que debe restablecer la base de datos, 



USUARIOS/SCHEMAS 

PERMISOS 

TABLAS PERMISOS 

TABLAS USUARIOS 

TABLESPACE 

MONITORES: 

Flujo de datos 

Flujo de control 

Explorador de paquetes 

Controlador de eventos 

Monitoreo y ajuste básico 

Hay tantos problemas diversos que pueden afectar el rendimiento de una base de datos Oracle. Como nuevo DBA, debe ser capaz de comprender los diferentes tipos de cuellos de botella que pueden ocurrir y ser capaz de encontrar soluciones. Para mencionar solo algunos: use eventos de espera comunes, verifique si se está utilizando el índice correcto y vuelva a generar índices y tablas si es necesario para eliminar la fragmentación, aprende a utilizar las herramientas de análisis de sentencias 

SQL explain plan y tkprof para analizar los planes de ejecución y los costes de cada sentencia, buscando cuales son aquellas que pueden estar colapsando el sistema por consumo de CPU, accesos a disco. 

Copia de seguridad y recuperación de bases de datos 

Una de las principales responsabilidades de un DBA de Oracle es garantizar la continuidad y la disponibilidad de la base de datos. De hecho, varias compañías usan KPI basadas en el tiempo medio de disponibilidad entre fallas para evaluar el desempeño de los DBA. Hay habilidades que deberá recoger para garantizar la disponibilidad de la base de datos. Una de ellas es poder utilizar las funciones de copia de seguridad y restauración nativas de Oracle con RMAN e integrarlas con otras herramientas similares de terceros como Dataprotector, Netbackup. Inyeccion SQL. 

Buen conocimiento de los paquetes del RDBMS 

Un DBA principiante debe comprender el propósito detrás de la serie de paquetes DBS que vienen incluidos con el motor de la Base de Datos Oracle. Estos paquetes amplían las funcionalidades de la Base de Datos. Sin estos paquetes, no sería posible usar PL/SQL con muchas características estándar de Oracle. Como nuevo DBA, no necesitas conocer todos y cada uno de estos paquetes, pero al menos debes de tener una buena idea de la utilidad y la funcionalidad que ofrecen cada uno de esos paquetes. 

CONSULTAS EN SQL: 



ETL: Operaciones que extraen datos de una fuente, las trasforman y la cargan en otra ubicación. 

DATOS ESTRUCTURADOS 

Tiene un formato especifico y siguen cierto orden, son como los ladrillos y el cemento en el mundo de las bases de datos. Son baratos, inflexibles y hace falta mucho diseño previo. Se basan en el modelo de datos. 

Un modelo de datos es parecido a los esquemas de una base de datos relacional, salvo que el esquema acaba definiendo toda la estructura de la base de datos. Un esquema te muestra cómo organizar tu base de datos relacional. Incluye la tabla, las relaciones y las interconexiones que existen. Un modelo de datos define la estructura de los campos individuales. Se decide si el campo tendrá, textos, números o fechas. 

Ej: Los extractos bancarios, la informacion de vuelos, los horarios del bus, agenda de direcciones. 

DATOS semiestructurados  

(combinar mis datos estructurados con otros datos estructurados) 

(XML) Extensible Markup Language *antiguo 

(JSON) JavaScript Object Notation *forma actualizada 

Ej: Un correo electrónico, 

DATOS NO ESTRUCTURADOS 

Videos, imágenes y audios.  Abarcan todo lo demás. Aprox el 80% de todos los datos. 

NOSQL

BIGDATA, las cuatro V (deben cumplir con los 4 atributos) 

Volumen ¿tengo un volumen elevado de datos? 

Variedad ¿hay una gran variedad de datos? 

Velocidad ¿los datos llegan a gran velocidad? 

Veracidad ¿los datos que recojo son veraces? ¿me darán conocimiento o revelaciones? 

Si recoges Petabytes de informacion cada día, tiene un volumen suficiente. 

En el futuro quizás haga falta un Exabyte para que se considere un problema. 

Ej: Video, audio, twits, facebook…  

Un auto tiene que procesar, videos, audios, coordenadas de mapa para tomar decisiones. Son problemas del BIGDATA. 

Funciones en SQL  

Es un grupo de instrucción que se ejecuta al ser llamadas desde un programa, o procedimiento. Están reciben datos de entradas que son trasformados para después arrojar un resultado, en general las funciones deben tener un nombre único, para evitar que el sistema sufra confusiones, en SQL existen 3 tipos de funciones: 

FUNCIONES ESCALARES. 

FUNCIONES EN LINEA. 

FUNCIONES EN LINEA DE MULTIPLE SENTENCIA. 

1. Funciones escalares. 

Devuelven un único valor de cualquier tipo de datos. 

EJEMPLO, FUNCION ESCALAR «obtener IVA» 

EJECUCION DE UNA FUNCION, se debe crear una consulta. Por ej realizar una búsqueda. 

Las funciones siempre deben ejecutarse dentro de una sentencia, por ej: SELECT, no se pueden ejecutar solas. 

2. Funciones en línea. 

Son aquellas que regresan un conjunto de resultados correspondientes a una sentencia SELECT, por lo tanto, el resultado es una TABLA. 

Ej: Arrojar todos los clientes de una misma nacionalidad, Como el retorno de la función es un dato tipo tabla, este se llama con una instrucción select, especificando el parámetro de entrada. 

3.Funciones en línea de múltiple sentencia. 

Son similares a las funciones en línea y cierto que el resultado está compuesto por la ejecución de varios selects, por lo general se utilizan cuando se requieren de mayor lógica de proceso. 

Ej: Función que traiga a cada cliente por país. 

TRIGGERS en SQL 

Disparadores de eventos, estos activaran procesos automáticos en la base de datos, al utilizar una instrucción DML especifica. Cada trigger está anclado solamente a una tabla y funcionan para proteger a la base de datos de alteraciones. 

INSERT, DELETE, UPDATE, 

Ej: cuando exista una inserción en la tabla ORDEN_DETAILS, se reste la cantidad de productos comprados en la tabla PRODUCTS. 

Verificando los errores, validado que lo que haga el trigger lo haga. 

Si resta un valor, validar la resta. Si suma, validad la suma… 

PROCEDIMIENTO ALMACENADOS 

Es un conjunto de instrucciones que son ejecutadas cuando lo decidas, pueden aceptar parámetros de entrada y generar o no resultados, dentro de ellos puedes ejecutar otros procedimientos almacenados por lo general siempre regresan un valor de estado para indicar si la operación fue concluida exitosamente. Los procedimientos almacenados llaman a la base de datos, con el código que contengan y terminan la llamada cuando terminan el procedimiento, operación más segura que por ejemplo tener el código suelto que llama a la base y sale de ella por línea de código. 

También varios usuarios o clientes pueden ejecutar procesos de tareas específicas y sin meterse con el código SQL. Reutilizar código es una buena práctica, para el administrador de base de datos, ya que al meter código frecuente en un procedimiento los programas se vuelven más sencillos y con mejor rendimiento. 

EXECUTE procedure_name; 

Lo usos de procedimientos son muy extensos, por lo que necesitar conocer y aplicarlos en bases de datos, FUNCIONES y PROCEDIMIENTOS ALMACENADOS, 

Los procedimientos son llamados únicamente cuando tú lo deseas, por medio de la instrucción EXECUTE. Mientras que las FUNCIONES, son llamadas dentro de otra sentencia. 

Además, con los procedimientos almacenados, puedes restringir acciones de usuario a un nivel más específico, por EJ: 

 A un usuario que no tiene control de la tabla de inventario, cada vez que se realiza la venta de un producto, y se debe registrar un decremento en el inventario, se le pude dar acceso a un procedimiento almacenado que registre el producto vendido sin que el usuario cambie arbitrariamente la tabla inventario. 



Cada negocio tiene REGLAS PROPIAS. modelado de un ambiente de negocios. 

Producto del proveedor. 

Un proveedor vende ninguno o varios productos. 

Un producto tiene solo una categoría. 

Una categoría puede tener ninguno o muchos productos. 

Un empleado realiza varias ventas. 

Una venta le pertenece a un empleado. 

Un cliente realiza varias compras. 

Una venta pertenece a un cliente. 

Una venta puede tener muchos productos. 

Un producto puede estar en varias ventas. 

SACAR SU CARDINALIDAD 

DATAWAREHOUSE. Almacén de datos, diseño y operación. 

Aplicaciones, es una base de datos orientada al análisis de informacion, se olvida de las transacciones. CARACTERÍSTICAS: 

1. Orientado a temas, todos los datos deben estar relacionados respecto al tema a analizar. 

2. Variante en el tiempo, lo cambios de los datos en el tiempo deben quedar registrados para evitar pérdidas de informacion. 

3. No Volátil, la informacion no se modifica ni se elimina, solo es de lectura, 

La función del datawarehouse es contener los datos útiles para el ambiente de negocios y posteriormente transformarlos en informacion relevante, que se pueda analizar rápidamente, de esta forma los usuarios autorizados pueden realizar consultas sin alteraciones del sistema. 

Principio de separación de los datos, se debe separar los datos utilizados en operación de bases de datos de los datos que se guardan en el almacén para que nunca coincidan, con este principio de diseñan los ETL. 

DATAMARTS. Son bases de datos departamentales, que se alimentan del datawarehouse, con el fin de evitar una búsqueda extensiva del datawarehouse por parte del sistema y asi recibir la informacion más rápido. EJ: El en datawarehouse de una tienda existen datamarts de áreas específicas como recursos Humanos, ventas, compras, a cada uno de estos datamarts tiene permisos una cantidad limitada de usuarios que acceden a la informacion con ANALISIS DE PROPOSITO especifico. Para analisis de DATAMARTS se contemplan la estructura multidimensionales, como los cubos relacionales. Podeer proveeer respuestas sobre el funcionamiento de la empresa, informacion relevamente para la toma de desciones. 

Esquema ESTRELLA: el mas simple.  

Tabla de HECHOS la central, está rodeada de entidades llamadas dimensiones y lleva lógica relacional en que las tablas de hechos recaen en la segunda forma normal. Hace posible que la programación de la consulta sea más simple y rápida. Solo existe una tabla de dimensiones por dimensión. 

¿Cuántos productos se vendieron? 
¿Quién vendió cada uno? 
¿Quién compro cada uno? 
¿Cuándo ocurrió? 

 Esquema de copo de nieve. 

Está diseñado para el mantenimiento de dimensiones, parecido con un modelo relacional ya que cumple con la tercera forma normal. Trata de segmentar informacion en caso de que esta sea muy extensa, ahorra espacio en memoria, para tablas de muchos registros, segmentar por grupos las tablas, de esta manera no usamos una misma tabla para misma consulta y segmentamos la carga de cómputo en memoria. 

Esquema constelación. 

Existe más de una tabla de hechos, así las tablas de dimensiones pueden estar repartidas entre las múltiples tablas de hechos, con el fin de tener diferentes aspectos del negocio registrado. 

VENTAS POR MES 
PRODUCTO MAS VENDIDO 

EMPLEADO DEL MES 
BONO DE EMPLEO 

 La gran ventaja de este tipo de esquemas es su gran flexibilidad, pero al generarla se sacrifica su facilidad y pueden ser difíciles de mantener en un futuro por el crecimiento de los datos, logra la misma velocidad de búsqueda que el esquema estrella, siempre y cuando se genere una tabla por dimensión. 

 ¿Bono por mes para cada empleado en cada uno de los territorios? Con esto sabrá el rendimiento de cada empleado, 

SOLUCION= tomar el esquema estrella y agregar otra tabla de hechos, en esta crea llaves primerias de las dimensiones de tiempo, producto y empleado. Además, crea la dimensión geográfica para conocer el territorio de donde proviene el empleado. La segunda tabla de hechos se llamará BONOS POR EMPLEADO y resolverá este aspecto del negocio. 