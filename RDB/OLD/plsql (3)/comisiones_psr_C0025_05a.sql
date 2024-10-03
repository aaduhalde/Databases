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
PROMPT Archivo.................: comisiones_psr_C0025_05a.sql
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
/*********************************************************************
              
              Descripcion del Script
              ----------------------
Se eliminan las tablas auxiliares

*********************************************************************/
PROMPT *******************************************************************Procesamiento
PROMPT * * *  Borrando Tablas Auxiliares...
SET TIMING ON
WHENEVER SQLERROR CONTINUE
DROP TABLE AUX_C0025_PRIM_REC_01_A PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_01_B PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_01_C PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_01 PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_02 PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_03 PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_04 PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_05_1 PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_05_2 PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_05_3 PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_05 PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_06 PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_07_A PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_07 PURGE
/
DROP TABLE AUX_C0025_PROD_ITEMS_01_A PURGE
/
DROP TABLE AUX_C0025_PROD_ITEMS_01 PURGE
/
DROP TABLE AUX_C0025_PROD_ITEMS_02 PURGE
/
DROP TABLE AUX_C0025_PROD_ITEMS_03 PURGE
/
DROP TABLE AUX_C0025_PROD_ITEMS_04 PURGE
/
DROP TABLE AUX_C0025_PROD_ITEMS_05 PURGE
/
DROP TABLE AUX_C0025_TRANS_PRETUPS_01 PURGE
/
DROP TABLE AUX_C0025_TRANS_PRETUPS_02 PURGE
/
DROP TABLE AUX_C0025_TRANS_PRETUPS PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_08 PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_09 PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_10 PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_11_A PURGE
/
DROP TABLE AUX_C0025_PRIM_REC_11 PURGE
/
DROP TABLE AUX_C0025_PRE_INSERT_BSC PURGE
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
         ,'comisiones_psr_C0025_05a'
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