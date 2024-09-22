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
PROMPT Archivo.................: comisiones_psr_C0025_01n.sql
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
/*********************************************************************
              
              Descripcion del Script
              ----------------------
Se unen los registros de ambas tablas auxiliares y se busca la primer recarga de cada handle

*********************************************************************/
PROMPT *******************************************************************Procesamiento
PROMPT * * *  Creando la AUX_C0025_PRIM_REC_05...
SET TIMING ON
CREATE TABLE AUX_C0025_PRIM_REC_05
TABLESPACE &v_tbs_admin
NOLOGGING 
AS
  SELECT /*+ parallel(c,4) */
         handle
        ,MIN(fecha_transaccion) fecha_transaccion
    FROM (SELECT /*+ parallel(a,4) */
                 handle
                ,fecha_transaccion
            FROM aux_c0025_prim_rec_05_3 a
          UNION ALL
          SELECT /*+ parallel(b,4) */
                 handle
                ,fecha_transaccion
            FROM aux_c0025_prim_rec_05_1 b) c
GROUP BY handle
HAVING MIN(fecha_transaccion) >= TO_DATE('&v_fecha_proceso', 'dd/mm/yyyy')
   AND MIN(fecha_transaccion) < TO_DATE('&v_fecha_proceso', 'dd/mm/yyyy') + 1
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
         ,'comisiones_psr_C0025_01n'
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