
prompt ****************************************************************
prompt Efectividad IRIS
prompt ****************************************************************
prompt Archivo....: efectividad_iris_4389_01v.sql 
prompt Autor......: Soledad Zubizarreta
prompt Reviso.....:
prompt Produccion.:
prompt DescripciÛn: Se crea Universo PSR
prompt 				
prompt *****************************************************************
prompt Historia del Proceso
prompt Fecha        Por           Descripcion
prompt **********   ***********   **************************************
prompt 22/06/2020   S.Zubizarreta     Creacion del script
prompt *****************************************************************
prompt Seteos Iniciales
prompt *****************************************************************

@/racing/replica/seteos_iniciales.sql
select to_char(sysdate, 'yyyy-mm-dd hh24.mi.ss') "Tiempo Inicio" from dual
/
prompt ****************************************************************
prompt Lectura de tablas de par·metros
prompt ****************************************************************

col tbs_admin    		    new_value v_tbs_admin       noprint
col esquema_rac8        new_value v_esquema_rac8    noprint     

SELECT 
   pck_core.fc_get_parameter ('CORE', 'TBS_ADMIN')    tbs_admin,
   pck_core.fc_get_parameter('CORE','ESQUEMA_RAC8') esquema_rac8
FROM DUAL
/
COL esquema_iris new_value v_esquema_iris	noprint 
SELECT  par_value_varchar2 esquema_iris
FROM  param_actualiz_racing
WHERE par_procedure_name = 'CORE'
AND par_parameter_name = 'ESQUEMA_IRIS'
  /
COL fecha_proceso new_value v_fecha_proceso	noprint                                                     
SELECT par_value_date fecha_proceso
FROM PARAM_ACTUALIZ_RACING
WHERE par_procedure_name = 'EFECTIVIDAD_IRIS'
AND par_parameter_name = 'FECHA_PROCESO' 
/
PROMPT ****************************************************************
PROMPT Par·metros
PROMPT ****************************************************************
PROMPT Par·metro: [fecha_proceso]     - Valor: [&v_fecha_proceso]
PROMPT Par·metro: [esquema_rac8]      - Valor: [&v_esquema_rac8]
PROMPT Par·metro: [tbs_admin]         - Valor: [&v_tbs_admin]
PROMPT Par·metro: [esquema_iris]      - Valor: [&v_esquema_iris]
PROMPT ****************************************************************
PROMPT Actualizando datos en tabla 
PROMPT ****************************************************************
PROMPT Borrando datos de tabla 
PROMPT ****************************************************************
PROMPT ****************************************************************
PROMPT Creamos Dimension PSR AUX_G4389_IRIS_20
PROMPT ****************************************************************
create TABLE AUX_G4389_IRIS_20
TABLESPACE &v_tbs_admin 
NOLOGGING
AS
SELECT
         EX.PRT_EXTCODE EXCODAGENTE,
         AGT.AGT_NUMBER NROAGENTE,
         AGT.AGT_KEYNAME NOMBREAGENTE,
         WLK.WLK_POS POSVENDEDOR,
         WLK.ID IDVENDEDOR,
         POS.POSP_NIM POSPSR,
         PSR.POS_CODE CODPSR,
         UPPER(TRANSLATE(ADR.ADD_COUNTRY ,'·ÈÌÛ˙‡ËÏÚ˘„ı‚ÍÓÙÙ‰ÎÔˆ¸Á¡…Õ”⁄¿»Ã“Ÿ√’¬ Œ‘€ƒÀœ÷‹«','aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC')) PAIS,
         UPPER(TRANSLATE(ADR.ADD_CITY ,'·ÈÌÛ˙‡ËÏÚ˘„ı‚ÍÓÙÙ‰ÎÔˆ¸Á¡…Õ”⁄¿»Ã“Ÿ√’¬ Œ‘€ƒÀœ÷‹«','aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC')) CIUDAD,
         UPPER(TRANSLATE(ADR.ADD_DEPARTMENT ,'·ÈÌÛ˙‡ËÏÚ˘„ı‚ÍÓÙÙ‰ÎÔˆ¸Á¡…Õ”⁄¿»Ã“Ÿ√’¬ Œ‘€ƒÀœ÷‹«','aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC')) DEPARTAMENTO,
         UPPER(TRANSLATE(ADR.ADD_STATE ,'·ÈÌÛ˙‡ËÏÚ˘„ı‚ÍÓÙÙ‰ÎÔˆ¸Á¡…Õ”⁄¿»Ã“Ÿ√’¬ Œ‘€ƒÀœ÷‹«','aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC')) PCIA,
         REG.ID IDREGION,
         REG.REG_NAME NOMBREREGION,
         TRR.ID IDTRR,
         TRR.TRR_CODE CODTERR,
         TRR.TRR_NAME NOMBRETRR,
         DIZ.DIZ_NAME,
         ADR.ADD_LATITUDE,
         ADR.ADD_LONGITUDE
FROM 
    &V_ESQUEMA_RAC8.ITEC_POINTS_OF_SALES PSR
      LEFT JOIN &V_ESQUEMA_RAC8.ITEC_POS_NUMBERS POS 
       ON POS.POSP_POS_ID=PSR.ID 
      LEFT JOIN &V_ESQUEMA_RAC8.ITEC_TERRITORIES TRR 
       ON PSR.POS_TERR_ID = TRR.ID
      LEFT JOIN &V_ESQUEMA_RAC8.ITEC_REGIONS REG
        ON TRR.TRR_REG_ID = REG.ID
      LEFT JOIN &V_ESQUEMA_RAC8.ITEC_AGENTS AGT
        ON AGT.ID=TRR.TRR_AGT_ID
      LEFT JOIN &V_ESQUEMA_RAC8.ITEC_DISTRIBUTION_ZONES DIZ 
       ON PSR.POS_DIZ_ID = DIZ.DIZ_ID
      LEFT JOIN &V_ESQUEMA_RAC8.ITEC_AGENTS_WALKERS WLK 
       ON WLK.ID=DIZ.DIZ_WLK_ID
      LEFT JOIN &V_ESQUEMA_RAC8.ITEC_ADDRESSES ADR 
       ON PSR.POS_ADD_ID = ADR.ADD_ID
      LEFT JOIN &V_ESQUEMA_RAC8.ITEC_PRETUPS_ADDITIONAL_DATA EX 
       ON EX.PRT_ID=AGT.AGT_PRT_ID  
 WHERE 
       PSR.END_DATE IS NULL 
       AND POS.POSP_NIM IS NOT NULL


/
SELECT TO_CHAR (SYSDATE, 'dd/mm/yyyy hh24:mi:ss') "Tiempo fin"  FROM DUAL
/