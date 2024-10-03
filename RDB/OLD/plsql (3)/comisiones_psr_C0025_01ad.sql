SET TIMING OFF
SET SERVEROUTPUT ON SIZE 10000
SET VERIFY OFF
SET TRIM ON
SET HEAD OFF
WHENEVER SQLERROR EXIT ROLLBACK
COLUMN val_0 new_value v_hora_inicio noprint
SELECT TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss') val_0
  FROM DUAL
/
PROMPT **********************************************Inicio Script: &v_hora_inicio
PROMPT
PROMPT Proceso:................: COMISIONES PSR
PROMPT Archivo.................: comisiones_psr_C0025_01ad.sql
PROMPT Autor...................: Juan Laquiz
PROMPT Reviso..................: Juan Laquiz
PROMPT Produccion..............:
PROMPT Pedido de Cambio........: 
PROMPT Circuito de Desarrollo..: 
PROMPT
PROMPT ************************************************************Historial de Cambios
PROMPT
PROMPT Fecha...................: 05/10/2021
PROMPT Autor...................: Juan Laquiz
PROMPT
PROMPT ****************************************************************Seteos Iniciales
@/racing/replica/seteos_iniciales.sql
PROMPT ***********************************************************Lectura de Parametros
SET TIMING OFF
---------------------------------------------------------------------------------------
/*
       Parametro: Tablespace
*/
COLUMN parametro format a20
COLUMN v_1 new_value v_tbs_admin format a20 PRINT
SELECT RPAD( 'TABLESPACE', 20, '.') parametro
      ,pck_core.fc_get_parameter( 'CORE', 'TBS_ADMIN') v_1
  FROM dual
/
---------------------------------------------------------------------------------------
/*
       Parametro: Fecha de Proceso
*/
COLUMN parametro format a20
COLUMN v_4 new_value v_fecha_proceso format a20 PRINT
SELECT RPAD( 'FECHA_PROCESO', 20, '.') parametro
      ,par_value_date v_4
  FROM racing.param_actualiz_racing
 WHERE par_procedure_name = 'COMISIONES_PSR'
   AND par_parameter_name = 'FECHA_PROCESO'
/
---------------------------------------------------------------------------------------
/*
       Parametro: Pais
*/
COLUMN parametro format a20
COLUMN v_9 new_value v_pais format a20 PRINT
SELECT RPAD( 'PAIS', 20, '.') parametro
      ,par_value_varchar2 v_9
  FROM racing.param_actualiz_racing
 WHERE par_procedure_name = 'CORE'
   AND par_parameter_name = 'PAIS'
/
---------------------------------------------------------------------------------------
/*
       Parametro: Created_by
*/
COLUMN parametro format a20
COLUMN v_13 new_value v_created_by format a20 PRINT
SELECT RPAD( 'CREATED_BY', 20, '.') parametro
      ,par_value_varchar2 v_13
  FROM racing.param_actualiz_racing
 WHERE par_procedure_name = 'COMISIONES_PSR'
   AND par_parameter_name = 'CREATED_BY'
/
---------------------------------------------------------------------------------------
/*
       Parametro: Remarks
*/
COLUMN parametro format a20
COLUMN v_14 new_value v_remarks format a20 PRINT
SELECT RPAD( 'REMARKS', 20, '.') parametro
      ,par_value_varchar2 v_14
  FROM racing.param_actualiz_racing
 WHERE par_procedure_name = 'COMISIONES_PSR'
   AND par_parameter_name = 'REMARKS'
/
---------------------------------------------------------------------------------------
/*
       Parametro: Category_Code
*/
COLUMN parametro format a20
COLUMN v_15 new_value v_category_code format a20 PRINT
SELECT RPAD( 'CATEGORY_CODE', 20, '.') parametro
      ,par_value_varchar2 v_15
  FROM racing.param_actualiz_racing
 WHERE par_procedure_name = 'COMISIONES_PSR'
   AND par_parameter_name = 'CATEGORY_CODE'
/
/*********************************************************************
              
              Descripcion del Script
              ----------------------
Se genera una tabla con los datos sumarizados por NIM de PSR

*********************************************************************/
PROMPT *******************************************************************Procesamiento
PROMPT * * *  Creando la AUX_C0025_PRE_INSERT_BSC...
SET TIMING ON
CREATE TABLE AUX_C0025_PRE_INSERT_BSC 
TABLESPACE &v_tbs_admin
NOLOGGING
AS
SELECT /*+ parallel(a,4) */
       DISTINCT CAST('&v_pais' AS VARCHAR2(2)) network_code
               ,DECODE(destino_acreditacion,'PUNTO_VENTA',itec_posp_nim,nim_distribuidor) msisdn
               ,CAST(NULL AS VARCHAR2(20)) extcode
               ,CEIL(SUM(prt_comision_psr) OVER (PARTITION BY DECODE(destino_acreditacion,'PUNTO_VENTA',itec_posp_nim,nim_distribuidor))) quantity
               ,SUM(1) OVER (PARTITION BY DECODE(destino_acreditacion,'PUNTO_VENTA',itec_posp_nim,nim_distribuidor)) cantidad_recargas
               ,DECODE(destino_acreditacion,'PUNTO_VENTA',itec_posp_nim || TO_CHAR(SYSDATE - 1, 'ddmmyyhh24mi'),nim_distribuidor || TO_CHAR(SYSDATE - 1, 'ddmmyyhh24mi')) external_txn_number
               ,TO_DATE('&v_fecha_proceso','dd/mm/yyyy') external_txn_date
               ,CAST(NULL AS VARCHAR2(10)) status
               ,CAST(NULL AS VARCHAR2(40)) ERROR_CODE
               ,CAST(NULL AS NVARCHAR2(1000)) description
               ,SYSDATE created_on
               ,'&v_created_by' created_by
               ,CAST(NULL AS DATE) modified_on
               ,CAST(NULL AS VARCHAR2(20)) modified_by
               ,DECODE('&v_pais','AR','&v_remarks','UY',DECODE(destino_acreditacion,'PUNTO_VENTA','ISOP','ISOD')) remarks
               ,'&v_category_code' category_code
               ,CAST(NULL AS VARCHAR2(2)) sap_flag
               ,CAST(NULL AS VARCHAR2(20)) owner_externalcode
  FROM aux_c0025_prim_rec_11 a
 WHERE give_commission = 'YES'
/
SET TIMING OFF
COLUMN val_99 new_value v_hora_fin noprint
SELECT TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss') val_99
  FROM DUAL
/
PROMPT * * *  Insertando los tiempos de corrida en la tabla ARQ_LOG_PROCESOS...
SET TIMING ON
INSERT /*+ append */
      INTO  arq_log_procesos(alp_grupo
                            ,alp_procedure_name
                            ,alp_script
                            ,alp_fecha_corrida
                            ,alp_tiempo_horas
                            ,alp_tiempo_minutos
                            ,alp_tiempo_segundos
                            ,alp_tiempo)
   SELECT 'C0025'
         ,'COMISIONES_PSR'
         ,'comisiones_psr_C0025_01ad'
         ,TO_DATE('&v_hora_inicio', 'dd/mm/yyyy hh24:mi:ss')
         ,horas
         ,minutos
         ,FLOOR((minutos_exactos - minutos) * 60) segundos
         ,dias
     FROM (SELECT dias
                 ,horas
                 ,FLOOR((hora_exacta - horas) * 60) minutos
                 ,(hora_exacta - horas) * 60 minutos_exactos
             FROM (SELECT TO_NUMBER(TO_DATE('&v_hora_fin', 'dd/mm/yyyy hh24:mi:ss') - TO_DATE('&v_hora_inicio', 'dd/mm/yyyy hh24:mi:ss')) dias
                         ,FLOOR(TO_NUMBER(TO_DATE('&v_hora_fin', 'dd/mm/yyyy hh24:mi:ss') - TO_DATE('&v_hora_inicio', 'dd/mm/yyyy hh24:mi:ss')) * 24)
                             horas
                         ,TO_NUMBER(TO_DATE('&v_hora_fin', 'dd/mm/yyyy hh24:mi:ss') - TO_DATE('&v_hora_inicio', 'dd/mm/yyyy hh24:mi:ss')) * 24
                             hora_exacta
                     FROM dual))
/
COMMIT
/
PROMPT *************************************************Fin Script: &v_hora_fin
PROMPT
PROMPT