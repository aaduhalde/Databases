

Un lenguaje de programación está formado por un conjunto de palabras reservadas, 
símbolos y reglas sintácticas y semánticas que definen su estructura y 
el significado de sus elementos y expresiones. 

El proceso de programación consiste en la escritura, 
compilación y verificación del código fuente de un programa.
/////////////////////////////////////////////////////////////////////

Si un sistema no está bien modelizado, 
seguirá funcionando mal después de una ampliación de discos, 
de RAM o de CPU. 

La ampliación de hardware sólo puede justificarse ante un aumento del volumen de información
a gestionar y/o en el número de usuarios del sistema. 

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////







/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////


BDA-3341,  (PRiORIDAD MEDIA)
como sigue el problema con los archivos? 
el problema es con los archivos de origen, no? SI
el proceso genera archivos de salida o registra info en tablas? SI

El procesos genera la info de tablas, pero no con el archivo que me da el usuario. Con cualquier otro archivo con la misma info funciona ok.
LO ESTOY PROBANDO CON JUAN AHORA,

BDA-3405, (PRIORIDAD ALTA)
por que no se implementa?
si es demora del implementador insisti con él

Entiendo que no se implementa por que es "jueves/viernes" y hay orden de no implementar serca de los fines de semana.
Le enviare un mail el lunes a PEDRO.
 
     

/////////////////////////////////////////////////////////////////////

BDA-3067, (PRiORIDAD MEDIA)
cuando finaliza el desarrollo?

Estoy trabajando en el desarrollo ahora, es muy largo. 
Voy avanzando y validando la info con los usuarios.


Me acaban de asignar= (PRIORIDAD MEDIA)
 BDA-3584: ORENSE3, G3102 y G3440 (CON ERROR ACTUALMENTE EL 3440)
 



/*
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

select * from cat;
select * from user_role_privs;
select * from user_sys_privs;




PRACTICAS
PRACTICAS
EJERCICE
EJERCICE

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LINK PEDIDO OBJETO

LINK PEDIDO PERMISOS
https://smp.claro.com.ar/portal/shop/catalog/41cba975-fda4-4e95-9d01-0007743628dd

CARGA SD CORRER PROCESO MANUALMENTE =
http://produccionit.claro.amx/Querys/EjecucionQuerysMODIFICA
alejandro.duhalde@dicsys.com;matnunez@claro.com.ar;jlaquiz@claro.com.ar

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////// BASH
//////////////////////////////////////////////////////////////////////////////// BASH
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


select * from pydw.param_actualiz_racing
where par_procedure_name = 'MOMO_WALLET' and PAR_PARAMETER_NAME = 'PATH_SCRIPT'


anidado para armar el select,
--tambien se puede armar con un CASE, 
SELECT SUBSTR('PEPE PEREZ',6,3) FROM DUAL; 
SELECT SUBSTR('PEPE PEREZ',6,3) FROM DUAL; 
SELECT SUBSTR('PEPE PEREZ',6,3) FROM DUAL; 
SELECT SUBSTR('PEPE PEREZ',6,3) FROM DUAL; 
SELECT SUBSTR('PEPE PEREZ',6,3) FROM DUAL; 
SELECT SUBSTR('PEPE PEREZ',6,3) FROM DUAL; 
SELECT SUBSTR('PEPE PEREZ',6,3) FROM DUAL
/

--Create CSV, JSON
--CREATE TABLE from CSV, JSON
--TNS CONFIG= 
tnsping HR

--CASE
SELECT UNIQUE COUNTRY_ID ID,
CASE COUNTRY_ID
WHEN 'AU' THEN 'Australia'
WHEN 'BR' THEN 'Brazil'
WHEN 'CA' THEN 'Canada'
WHEN 'CH' THEN 'Switzerland'
WHEN 'CN' THEN 'China'
WHEN 'DE' THEN 'Germany'
WHEN 'IN' THEN 'India'
WHEN 'IT' THEN 'Italy'
WHEN 'JP' THEN 'Japan'
WHEN 'MX' THEN 'Mexico'
WHEN 'NL' THEN 'Netherlands'
WHEN 'SG' THEN 'Singapore'
WHEN 'UK' THEN 'United Kingdom'
WHEN 'US' THEN 'United States'
ELSE 'Unknown'
END COUNTRY
FROM LOCATIONS
ORDER BY COUNTRY_ID;

--DECODE
--LOOPS
--FUNCTION
--PROCEDURE

SELECT * FROM DRACING.param_actualiz_racing
WHERE par_procedure_name = 'COMISIONES_PSR'
AND par_parameter_name = 'PROMO'

DELETE FROM param_actualiz_racing
WHERE par_procedure_name = 'COMISIONES_PSR'
/
INSERT INTO param_actualiz_racing
SELECT * FROM RACING.param_actualiz_racing
WHERE par_procedure_name = 'COMISIONES_PSR'
/
COMMIT
/

SELECT * FROM dba_directories
WHERE DIRECTORY_NAME ='D_D_G4703_SF_MKT_DIG_CAMPA'

SELECT * FROM dba_directories
WHERE DIRECTORY_NAME ='D_D_G4704_SF_MKT_DIG_TRAKI'


//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////  //////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////  //////////////////////////////////////////////////////////////////////////////////

select * from racing.param_actualiz_racing  
where par_procedure_name = 'X_PIN_CONTACT_HISTORY'

select grupo, a.* from  racing.actualizacion_racing a
where act_table_name like '%CELLULAR_TERM%'

select grupo, a.* from racing.actualizacion_racing a
where act_table_name like '%INC_ID_CEL%'

SELECT * FROM dba_views WHERE view_name LIKE '%C0024%'
SELECT * FROM dba_views WHERE view_name LIKE '%C0024%'

SELECT min(sch_id) val2, max(sch_id) val3 from &esquema.schedulers
WHERE  sch_end_date > TO_DATE (LAST_DAY (ADD_MONTHS (('&fecha_proceso'), -1))) 

SET timing on
SET serveroutput on size 10000
WHENEVER sqlerror exit rollback
SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo_inicio
FROM DUAL
/


/*    
  column FIRST_NAME format a10;
	column LAST_NAME  format a10;

 SELECT EMPLOYEE_ID ALIAS1, FIRST_NAME, LAST_NAME, SALARY, MANAGER_ID
 FROM HR.EMPLOYEES
 WHERE SALARY > 10000
 and MANAGER_ID = 100
/

SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24.mi.ss') tiempo_FIN
FROM DUAL
/





--Generacion de archivo .csv
--Lo generaremos mediante el paquete UTL_FILE en PL/SQL, adjunto script de ejemplo:
DECLARE
p_filedir VARCHAR2 (2000);
p_filename VARCHAR2 (2000);
v_filehandle UTL_FILE.file_type;

BEGIN
p_FileDir := 'nombre_dirctorio_oracle';
p_filename := 'nombre_archivo.csv';
v_filehandle := UTL_FILE.FOPEN (p_filedir,p_filename,'W');
UTL_FILE.PUT_LINE (V_FILEHANDLE,
                    'CAMPO1' || '|' ||
                    'CAMPO2' || '|' ||
                    'CAMPO3' || '|' ||
                    'CAMPO4' || '|' ||
                    );

FOR C IN (SELECT * FROM TABLA_A_EXPORTAR)
  LOOP
       UTL_FILE.PUT_LINE(V_FILEHANDLE,
        C.'CAMPO1' || '|' ||
        C.'CAMPO2' || '|' ||
        C.'CAMPO3' || '|' ||
        C.'CAMPO4' || '|' ||
          );
END LOOP;
 
UTL_FILE.FCLOSE (V_FILEHANDLE);
END;

Envío de mail con archivo adjunto
Una de las formas mas simples que encontré de hacer esto es mediante la instrucción de Linux mailx
!echo -e "Cuerpo del mail" | mailx -s "Asunto" -a ruta_archivo_adjunto lista_mails

Aclaraciones:
Esto es un comando de Linux, NO de PL/SQL
Debe ir el símbolo ! adelante del comando para que cuando lo corramos el servidor detecte que se esta leyendo un comando que no es sql dentro del script .sql
La opción -e, hace que se detecten caracteres especiales (por ejemplo si queremos hacer un salto de línea(\n))
La opción -s: establece la información del asunto del correo electrónico.
Con la opción -a pasamos la ruta del archivo a adjuntar(con el nombre del archivo incluido)
Al final pasamos el/los mails de destinos, si es mas de uno van separados por un espacio.
Respetar siempre los espacios en blanco
Opcion adicional(no la probe)
-c: Use una lista CC.
Con la opción -r le podemos pasar el mail de origen desde donde disparamos el email


SELECT * FROM ALL_OBJECTS WHERE OBJECT_TYPE = 'FUNCTION' and OWNER='RACING'
*/





COMMIT
/

