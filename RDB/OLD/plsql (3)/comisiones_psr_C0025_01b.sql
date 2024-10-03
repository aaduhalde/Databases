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
PROMPT Archivo.................: comisiones_psr_C0025_01b.sql
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
       Parametro: Esquema de Lectura de la base RAC8
*/
COLUMN parametro format a20
COLUMN v_2 new_value v_esquema_rac8 format a20 PRINT
SELECT RPAD( 'ESQUEMA RAC8', 20, '.') parametro
      ,pck_core.fc_get_parameter( 'CORE', 'ESQUEMA_RAC8') v_2
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
       Parametro: cantidad de digitos para tomar el numero de linea del pais
*/
COLUMN parametro format a20
COLUMN v_3 new_value v_digitos_nim format 99 PRINT
SELECT RPAD( 'DIGITOS_PAIS', 20, '.') parametro
      ,par_value_number v_3
  FROM param_actualiz_racing
 WHERE par_procedure_name = 'COMISIONES_PSR'
   AND par_parameter_name = 'DIGITOS_PAIS'
/
---------------------------------------------------------------------------------------
/*
       Parametro: factor de division del monto acreditado (varia de acuerdo al pais)
*/
COLUMN parametro format a20
COLUMN v_5 new_value v_factor_division_monto format 999999 PRINT
SELECT RPAD( 'MONTO_DIVISION', 20, '.') parametro
      ,par_value_number v_5
  FROM param_actualiz_racing
 WHERE par_procedure_name = 'COMISIONES_PSR'
   AND par_parameter_name = 'MONTO_DIVISION'
/
/*********************************************************************
              
              Descripcion del Script
              ----------------------
Se buscan las recargas del dia anterior en la tabla GSM_FILE_DETAILS_ALTERNATIVO

*********************************************************************/
PROMPT *******************************************************************Procesamiento
PROMPT * * *  Creando la AUX_C0025_PRIM_REC_01_B...
SET TIMING ON
CREATE TABLE AUX_C0025_PRIM_REC_01_B
TABLESPACE &v_tbs_admin
NOLOGGING 
AS 
SELECT *
  FROM (SELECT /*+ parallel(a,4) */
               gda_date + gda_start_time / 86400 fecha_recarga
              ,SUBSTR(gda_sub_id, -&v_digitos_nim, &v_digitos_nim) bill_number
              ,gda_transaction_type tt
              ,gda_external_transaction_type ett
              ,gda_account_balance_delta / &v_factor_division_monto monto
              ,CASE WHEN gda_transaction_type = 224 AND gda_external_transaction_type <> 25 THEN 'VIRTUAL'
                    WHEN gda_transaction_type = 224 AND gda_external_transaction_type = 25  THEN 'MAHINDRA/PRETUPS'
                    WHEN gda_transaction_type IN (1, 3)                                       THEN 'VOMS'
                    WHEN gda_transaction_type IN (15, 47)                                     THEN 'VIRTUAL'
                    END origen
              ,ROW_NUMBER() OVER(PARTITION BY gda_sub_id ORDER BY gda_start_time, ROWID) ranking
          FROM &v_esquema_rac8.gsm_file_details_alternativo a
         WHERE gda_date >= TO_DATE('&v_fecha_proceso', 'DD/MM/YYYY')
           AND gda_date < TO_DATE('&v_fecha_proceso', 'DD/MM/YYYY') + 1
           AND (gda_transaction_type IN (1, 3)
             OR (gda_transaction_type IN (224)
             AND gda_external_transaction_type IN (SELECT ore_idl_transaction_type
                                                     FROM &v_esquema_rac8.operation_reasons
                                                    WHERE tipo_razon = 'TV'
                                                      AND comision_flag = 'C'
                                                  )
                )
               )
       )
 WHERE ranking = 1
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
         ,'comisiones_psr_C0025_01b'
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