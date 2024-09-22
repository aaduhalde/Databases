prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01ap.sql 
prompt Autor......: Miguel peralta
prompt Reviso.....:
prompt Produccion.:
prompt Descripción: Inserta en la tabla final detallada por linea 				
prompt *****************************************************************
prompt Historia del Proceso
prompt Fecha        Por           Descripcion
prompt **********   ***********   **************************************
prompt 6/7/2020   M. Peralta     Creacion del script
prompt *****************************************************************
prompt Seteos Iniciales
prompt *****************************************************************
@/racing/replica/seteos_iniciales.sql 
alter session disable parallel dml 
/
prompt ****************************************************************
prompt Lectura de tablas de parámetros
prompt ****************************************************************
col tbs_admin    		    new_value v_tbs_admin       noprint
col esquema_rac8        new_value v_esquema_rac8    noprint   
SELECT 
   pck_core.fc_get_parameter ('CORE', 'TBS_ADMIN')    tbs_admin,
   pck_core.fc_get_parameter('CORE','ESQUEMA_RAC8') esquema_rac8
FROM DUAL
/
COL fecha_proceso new_value v_fecha_proceso	noprint                                                     
SELECT par_value_date fecha_proceso
FROM PARAM_ACTUALIZ_RACING
WHERE par_procedure_name = 'EFECTIVIDAD_IRIS'
AND par_parameter_name = 'FECHA_PROCESO' 
/
PROMPT ****************************************************************
PROMPT Parámetros
PROMPT ****************************************************************
PROMPT Parámetro: [fecha_proceso]     - Valor: [&v_fecha_proceso]
PROMPT Parámetro: [esquema_rac8]      - Valor: [&v_esquema_rac8]
PROMPT Parámetro: [tbs_admin]         - Valor: [&v_tbs_admin]
PROMPT Parámetro: [dbl_iris]          - Valor: [&v_dbl_iris]
PROMPT ****************************************************************
prompt Borrando particion Diaria
prompt ****************************************************************
/
DECLARE
	V_FECHA_PROCESO DATE :=	TO_DATE('&v_fecha_proceso','DD/MM/YYYY') ;
	PARTITION_NOT_EXIST EXCEPTION;
	PRAGMA EXCEPTION_INIT(PARTITION_NOT_EXIST, -2149);
	V_PARTICION VARCHAR2(30);
BEGIN
		V_PARTICION := TO_CHAR(V_FECHA_PROCESO,'YYYYMMDD');
		EXECUTE IMMEDIATE 'ALTER TABLE B_MEDICION_RECARGAS_IRIS TRUNCATE PARTITION FOR (TO_DATE('||V_PARTICION||',''YYYYMMDD''))';
EXCEPTION
	WHEN PARTITION_NOT_EXIST THEN
		NULL;
		DBMS_OUTPUT.PUT_LINE('LA PARTICION '||V_PARTICION||' NO EXISTENTE EN LA TABLA B_MEDICION_RECARGAS_IRIS');		
END;
/
PROMPT ****************************************************************
PROMPT Insert en la tabla detallada final B_MEDICION_RECARGAS_IRIS
PROMPT ****************************************************************
insert /*+ append */  into B_MEDICION_RECARGAS_IRIS
(
  ID_RECARGA,
  ANIO_MES                    ,
  DESC_ANIO_MES               ,
  FECHA_HORA_RECARGA, 
  FECHA_RECARGA ,
  CELLULAR_NUMBER,
  HANDLE  ,
  NEGOCIO_CLIENTE  ,
  DESC_NEGOCIO_CLIENTE ,
  MERCADO_CLIENTE ,
  DESC_MERCADO_CLIENTE ,
  SEGMENTO_CLIENTE ,
  NRO_AGENTE ,
  CELLULAR_NUMBER_PSR ,
  CIUDAD_PSR ,
  PROVINCIA_PSR ,
  LATITUD ,
  LONGITUD ,
  ID_OFERTA_COMPRADA ,
  NOMBRE_OFERTA_COMPRADA ,
  TIPO_OFERTA_COMPRADA ,
  NOMBRE_CAMPANA_COMPRADA ,
  CANAL ,
  MONTO_ORIGINAL ,
  MONTO_RECARGA ,
  BONUS_CLIENTE ,
  CANTIDAD_TRANSACCIONES ,
  MONTO_ADICIONAL_UP ,
  MONTO_ADICIONAL_RECO_RECARGA ,
  OFERTAS_RECOMENDADAS ,
  ID_OFERTA_RECOMENDADA ,
  NOMBRE_OFERTA_RECOMENDADA ,
  NOMBRE_CAMPANA_RECOMENDADA ,
  TIPO_OFERTA_RECOMENDADA ,
  MONTO_OFERTA_RECOMENDADA ,
  ID_PAQUETE ,
  CANT_PAQUETES,
  BAND_UP,
  BAND_RECO_RECARGA     ,
  CANT_RECARGAS               ,
  CANT_LINEAS                 ,
  CANT_OFERTAS_RECOM          ,
  CANT_NO_ACEPTO              ,
  CANT_SEGMENTADO             , 
  CANT_UPSELLING              ,   
  CANT_RECO_RECARGA           ,
  AVG_RECARGAS                ,        
  AVG_UPSELLING               ,       
  AVG_RECO_RECARGA            ,        
  TASA_DE_CONVERSION             ,   
  CANT_PSR                    )
SELECT
  I39.ID_TRANSACCION ,
   TO_CHAR(I39.FECHA_RECARGA,'YYYYMM'),
  TO_CHAR(I39.FECHA_RECARGA,'Mon YYYY'), 
  I39.FECHA_HORA_RECARGA,
  I39.FECHA_RECARGA,
  I39.CELLULAR_NUMBER_CLI,
  I39.HANDLE_CLIENTE,
  I39.ID_NEGOCIO_CLIENTE,
  I39.DESC_NEGOCIO_CLIENTE,
  I39.ID_MERCADO_CLIENTE,
  I39.DESC_MERCADO_CLIENTE,
  I39.SEGMENTO_CLIENTE,
  I39.NRO_AGENTE,
  I39.CELLULAR_NUMBER_PSR,
  I39.CIUDAD_PSR,
  I39.PROVINCIA_PSR,
  I39.LATITUD,
  I39.LONGITUD,
  I39.ID_OFERTA_COMPRADA,
  I39.NOMBRE_OFERTA_COMPRADA,
  I39.TIPO_OFERTA_COMPRADA,
  I39.NOMBRE_CAMPANA_COMPRADA,
  I39.CANAL,
  I39.MONTO_ORIGINAL_CLI,
  I39.MONTO_RECARGA_CLI,
  I39.MONTO_ADICIONAL_CLI,
  I39.CANTIDAD_TRANSACCINES,
  I39.MONTO_EXTRA_UP,
  I39.MONTO_EXTRA_RECO_RECARGA ,
  I39.OFERTAS_RECOMENDADAS,
  I39.ID_OFERTA_RECOMENDADA,
  I39.NOMBRE_OFERTA_RECOMENDADA,
  I39.NOMBRE_CAMPANA_RECOMENDADA, 
  I39.TIPO_OFERTA_RECOMENDADA,
  I39.MONTO_OFERTA_RECOMENDADA ,
  I39.ID_PAQUETE,
  I39.CANTIDAD_PAQUETES,
  CASE WHEN I39.MONTO_EXTRA_UP > 0 THEN 1 ELSE 0 END BAND_UP,
  CASE WHEN I39.MONTO_EXTRA_RECO_RECARGA > 0 THEN 1 ELSE 0 END BAND_RECO_RECARGA,
    COUNT(DISTINCT I39.ID_TRANSACCION),-- CANT_RECARGAS,
  COUNT (DISTINCT I39.CELLULAR_NUMBER_CLI),-- CANT_LINEAS --PARA EL PASAJE A PRODUCCION ESTE CAMPO NO VA, VERIFICAR QUE TAMPOCO ESTE EN EL CREATE TABLE
  --COUNT (I39.ID_OFERTA_RECOMENDADA),-- CANT_OFERTAS_RECOM
  CASE WHEN I39.TIPO_OFERTA_COMPRADA = 0 THEN 0 ELSE COUNT(1) END, -- CANT_OFERTAS_RECOM
  CASE WHEN I39.TIPO_OFERTA_COMPRADA = 0 THEN COUNT(1) ELSE 0 END, -- CANT_NO_ACEPTO 
  CASE WHEN I39.TIPO_OFERTA_COMPRADA = 1 THEN COUNT(1) ELSE 0 END, -- CANT_SEGMENTADO  
  CASE WHEN I39.TIPO_OFERTA_COMPRADA = 2 THEN COUNT(1) ELSE 0 END, -- CANT_UPSELLING    
  CASE WHEN I39.TIPO_OFERTA_COMPRADA = 3 THEN COUNT(1) ELSE 0 END, -- CANT_RECO_RECARGA  
  SUM (I39.MONTO_RECARGA_CLI)/ COUNT (DISTINCT I39.ID_TRANSACCION), --AVG_RECARGAS        
  CASE WHEN I39.TIPO_OFERTA_COMPRADA = 2 THEN SUM (I39.MONTO_EXTRA_UP)/ COUNT (DISTINCT I39.ID_TRANSACCION) ELSE 0 END, --  AVG_UPSELLING        
  CASE WHEN I39.TIPO_OFERTA_COMPRADA = 3 THEN SUM (I39.MONTO_EXTRA_RECO_RECARGA)/ COUNT (DISTINCT I39.ID_TRANSACCION) ELSE 0 END, --  AVG_RECO_RECARGA        
  CASE WHEN I39.CONVERSION = 'Y' THEN COUNT(I39.CONVERSION)/ COUNT (DISTINCT I39.ID_TRANSACCION) ELSE 0 END TASA_CONVERSION,---TASA_CONVERSION 
  COUNT (DISTINCT I39.CELLULAR_NUMBER_PSR)  ---CANT_PSR  
FROM AUX_G4389_IRIS_39 I39
GROUP BY
  I39.ID_TRANSACCION,
  TO_CHAR(I39.FECHA_RECARGA,'YYYYMM'),
  TO_CHAR(I39.FECHA_RECARGA,'Mon YYYY'),
  I39.FECHA_HORA_RECARGA,
  I39.FECHA_RECARGA,
  I39.CELLULAR_NUMBER_CLI,
  I39.HANDLE_CLIENTE,
  I39.ID_NEGOCIO_CLIENTE,
  I39.DESC_NEGOCIO_CLIENTE,
  I39.ID_MERCADO_CLIENTE,
  I39.DESC_MERCADO_CLIENTE,
  I39.SEGMENTO_CLIENTE,
  I39.NRO_AGENTE,
  I39.CELLULAR_NUMBER_PSR,
  I39.CIUDAD_PSR,
  I39.PROVINCIA_PSR,
  I39.LATITUD,
  I39.LONGITUD,
  I39.ID_OFERTA_COMPRADA,
  I39.NOMBRE_OFERTA_COMPRADA,
  I39.TIPO_OFERTA_COMPRADA,
  I39.NOMBRE_CAMPANA_COMPRADA,
  I39.CANAL,
  I39.MONTO_ORIGINAL_CLI,
  I39.MONTO_RECARGA_CLI,
  I39.MONTO_ADICIONAL_CLI,
  I39.CANTIDAD_TRANSACCINES,
  I39.MONTO_EXTRA_UP,
  I39.MONTO_EXTRA_RECO_RECARGA ,
  I39.OFERTAS_RECOMENDADAS,
  I39.ID_OFERTA_RECOMENDADA,
  I39.NOMBRE_OFERTA_RECOMENDADA,
  I39.MONTO_OFERTA_RECOMENDADA ,
  I39.ID_PAQUETE,
  I39.CANTIDAD_PAQUETES,
  I39.NOMBRE_CAMPANA_RECOMENDADA, 
  I39.TIPO_OFERTA_RECOMENDADA,
  I39.CONVERSION ,
  CASE WHEN I39.MONTO_EXTRA_UP > 0 THEN 1 ELSE 0 END ,
  CASE WHEN I39.MONTO_EXTRA_RECO_RECARGA > 0 THEN 1 ELSE 0 END 
/
prompt ****************************************************************
prompt Actualizando indice de tabla
prompt ****************************************************************
UPDATE ACTUALIZACION_RACING
SET    ACT_OLD_DATE 			= ACT_ACTUALIZ_DATE,
       ACT_ACTUALIZ_DATE 	= SYSDATE
WHERE  ACT_TABLE_NAME 		= 'EFECTIVIDAD_IRIS'
/
COMMIT
/
prompt ****************************************************************
prompt Fin Script
prompt ****************************************************************
select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') "Hora Fin" from dual
/