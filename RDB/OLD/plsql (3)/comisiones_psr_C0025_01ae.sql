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
PROMPT Archivo.................: comisiones_psr_C0025_01ae.sql
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
  FROM param_actualiz_racing
 WHERE par_procedure_name = 'COMISIONES_PSR'
   AND par_parameter_name = 'FECHA_PROCESO'
/
---------------------------------------------------------------------------------------
/*
       Parametro: Esquema Pretups
*/
COLUMN parametro format a20
COLUMN v_16 new_value v_esquema_prtps format a20 PRINT
SELECT RPAD( 'ESQUEMA PRETUPS', 20, '.') parametro
      ,par_value_varchar2 v_16
  FROM param_actualiz_racing
 WHERE par_procedure_name = 'CORE'
   AND par_parameter_name = 'ESQUEMA_PRTPS'
/
/*********************************************************************
              
              Descripcion del Script
              ----------------------
Se insertan los datos en las tablas finales sumarizadas

*********************************************************************/
PROMPT *******************************************************************Procesamiento
SET TIMING ON
PROMPT * * *  Borrando datos del proceso de la tabla BS_COMISION_PSR_FR...
DECLARE
   v_fecha_ini DATE := TO_DATE('&v_fecha_proceso', 'dd/mm/yyyy');
   v_particion VARCHAR2(1000);
BEGIN
   v_particion := 'ALTER TABLE BS_COMISION_PSR_FR TRUNCATE PARTITION FOR(TO_DATE(''' || TO_CHAR(v_fecha_ini, 'dd/mm/yyyy') || ''',''dd/mm/yyyy''))';
   DBMS_OUTPUT.put_line('Execute :' || v_particion);
   DECLARE
      partition_not_exist EXCEPTION;
      PRAGMA EXCEPTION_INIT(partition_not_exist,-2149);
   BEGIN
      EXECUTE IMMEDIATE v_particion;
      DBMS_OUTPUT.put_line('Se trunco la partición : ' || TO_CHAR(v_fecha_ini, 'dd/mm/yyyy'));
   EXCEPTION
      WHEN partition_not_exist
      THEN DBMS_OUTPUT.put_line('No existen particion para truncar');
   END;
END;
/
PROMPT * * *  Insertando datos del proceso en la tabla BS_COMISION_PSR_FR...
INSERT /*+ append parallel(a,4) */
      INTO  bs_comision_psr_fr a(network_code        --pais
                                ,msisdn              --NIM del PSR
                                ,extcode             --NULL a completar por pretups
                                ,quantity            --total de comision pagada al NIM del PSR
                                ,external_txn_number --concatenacion del nNIM del PSR y la fecha (formato 'ddmmyyhh24mi')
                                ,external_txn_date   --fecha_recarga
                                ,status              --NULL a completar por pretups
                                ,ERROR_CODE          --NULL a completar por pretups
                                ,description         --NULL a completar por pretups
                                ,created_on          --fecha de insercion
                                ,created_by          --NULL a completar por pretups
                                ,modified_on         --NULL a completar por pretups
                                ,modified_by         --disponible
                                ,remarks             --valor fijo 'Premio venta SIMs'
                                ,category_code       --valor fijo 'PO'
                                ,sap_flag            --NULL a completar por pretups
                                ,owner_externalcode  --NULL a completar por pretups
                                ,cantidad_recarga)   --cantidad de recargas
   SELECT /*+ parallel(a,4) */
          network_code
         ,msisdn
         ,extcode
         ,quantity
         ,external_txn_number
         ,external_txn_date
         ,status
         ,ERROR_CODE
         ,description
         ,created_on
         ,created_by
         ,modified_on
         ,modified_by
         ,remarks
         ,category_code
         ,sap_flag
         ,owner_externalcode
         ,cantidad_recargas
     FROM aux_c0025_pre_insert_bsc a
/
COMMIT
/
PROMPT * * *  Actualizando Diccionario de Datos...
UPDATE actualizacion_racing
   SET act_old_date = act_actualiz_date
      ,act_actualiz_date = sysdate
 WHERE act_procedure_name = 'COMISIONES_PSR'
   AND act_table_name = 'BS_COMISION_PSR_FR'
/
COMMIT
/
--PROMPT * * *  Borrando datos del proceso de la tabla PRTP01_AR.EXT_CLARO_FOC_TXN@PRTPS...
--DELETE /*+ parallel(a,4) */
--      FROM  prtp01_ar.ext_claro_foc_txn@prtps
--      WHERE external_txn_date >= TO_DATE('&v_fecha_proceso', 'dd/mm/yyyy')
--        AND external_txn_date < TO_DATE('&v_fecha_proceso', 'dd/mm/yyyy') + 1
--/
--COMMIT
--/
PROMPT * * *  Insertando datos del proceso en la tabla &V_ESQUEMA_PRTPS.EXT_CLARO_FOC_TXN@PRTPS...
INSERT /*+ append */
      INTO  &v_esquema_prtps.ext_claro_foc_txn@prtps(network_code
                                                    ,msisdn
                                                    ,extcode
                                                    ,quantity
                                                    ,external_txn_number
                                                    ,external_txn_date
                                                    ,status
                                                    ,ERROR_CODE
                                                    ,description
                                                    ,created_on
                                                    ,created_by
                                                    ,modified_on
                                                    ,modified_by
                                                    ,remarks
                                                    ,category_code
                                                    ,sap_flag
                                                    ,owner_externalcode)
   SELECT /*+ parallel(a,4) */
          network_code
         ,msisdn
         ,extcode
         ,quantity
         ,external_txn_number
         ,external_txn_date
         ,status
         ,ERROR_CODE
         ,description
         ,created_on
         ,created_by
         ,modified_on
         ,modified_by
         ,remarks
         ,category_code
         ,sap_flag
         ,owner_externalcode
     FROM aux_c0025_pre_insert_bsc a
/
COMMIT
/
PROMPT * * *  Actualizando Parametros de Corrida...
UPDATE param_actualiz_racing
   SET par_value_date = TRUNC(SYSDATE)
 WHERE par_procedure_name = 'COMISIONES_PSR'
   AND par_parameter_name = 'FECHA_PROCESO'
/
COMMIT
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
         ,'comisiones_psr_C0025_01ae'
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