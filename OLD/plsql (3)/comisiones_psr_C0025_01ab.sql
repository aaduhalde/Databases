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
PROMPT Archivo.................: comisiones_psr_C0025_01ab.sql
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
       Parametro: Pais
*/
COLUMN parametro format a20
COLUMN v_9 new_value v_pais format a20 PRINT
SELECT RPAD( 'PAIS', 20, '.') parametro
      ,par_value_varchar2 v_9
  FROM param_actualiz_racing
 WHERE par_procedure_name = 'CORE'
   AND par_parameter_name = 'PAIS'
/
---------------------------------------------------------------------------------------
/*
       Parametro: Exclusion_PSR
*/
COLUMN parametro format a20
COLUMN v_12 new_value v_exclusion_psr format a60 PRINT
SELECT RPAD( 'EXCLUSION_PSR', 20, '.') parametro
      ,par_value_varchar2 v_12
  FROM param_actualiz_racing
 WHERE par_procedure_name = 'COMISIONES_PSR'
   AND par_parameter_name = 'EXCLUSION_PSR'
/
/*********************************************************************
              
              Descripcion del Script
              ----------------------
Se buscan en la tabla ESN_CELLULARS algunos datos de la SIM.
Por otro lado, se calcula la comision a pagar

*********************************************************************/
PROMPT *******************************************************************Procesamiento
PROMPT * * *  Creando la AUX_C0025_PRIM_REC_11...
SET TIMING ON
CREATE TABLE AUX_C0025_PRIM_REC_11
TABLESPACE &v_tbs_admin
NOLOGGING
AS
SELECT /*+ parallel(a,4) parallel(b,4) */
      a.*
     ,b.esc_esn_hexa
     ,b.esc_start_date
     ,b.esc_end_date
     ,CASE
         WHEN itec_pos_code IS NOT NULL
          AND itec_pos_end_date IS NULL
          AND moi_ussd IS NOT NULL
          AND itec_pot_name NOT IN (&v_exclusion_psr) --AR: 'Local Claro Exclusivo' - UY: 'Local Claro Exclusivo'
          AND prt_comision_psr > 0
         THEN
            'YES'
         ELSE
            'NO'
      END give_commission
     ,CAST('PUNTO_VENTA' AS VARCHAR2(100)) destino_acreditacion
     ,CAST(NULL AS NUMBER) nim_distribuidor
  FROM aux_c0025_prim_rec_11_a a
      ,&v_esquema_rac8.esn_cellulars b
 WHERE '&v_pais' = 'AR'
   AND a.hea_upd_cellular_number_real = b.esc_clu_cellular_number(+)
   AND a.hea_upd_esn = b.esc_esn_hexa(+)
UNION ALL
SELECT /*+ parallel(a,4) parallel(b,4) parallel(c,4) */
      a.*
     ,b.esc_esn_hexa
     ,b.esc_start_date
     ,b.esc_end_date
     ,CASE
         WHEN itec_pos_code IS NOT NULL
          AND itec_pos_end_date IS NULL
          AND moi_ussd IS NOT NULL
          AND itec_pot_name NOT IN (&v_exclusion_psr) --AR: 'Local Claro Exclusivo' - UY: 'Local Claro Exclusivo'
          AND prt_comision_psr > 0
         THEN
            'YES'
         ELSE
            'NO'
      END give_commission
     ,CAST(CASE WHEN c.pos_code IS NOT NULL AND NVL(c.fecha_hasta,TO_DATE('31/12/3999','dd/mm/yyyy')) > a.fecha_proceso
           THEN 'DISTRIBUIDOR'
           ELSE 'PUNTO_VENTA'
           END AS VARCHAR2(100)) destino_acreditacion
     ,CAST(NVL2(c.pos_code, (SELECT msisdn
                               FROM &v_esquema_rac8.channel_user_master_data d
                              WHERE category_code = 'MI'
                                AND external_code LIKE 'MI%'
                                AND a.itec_ent_id = REPLACE(d.external_code, 'MI', '')
                             ),NULL) AS NUMBER) nim_distribuidor
  FROM aux_c0025_prim_rec_11_a a
      ,&v_esquema_rac8.esn_cellulars b
      ,&v_esquema_rac8.acreditacion_psrdistribuidor c
 WHERE '&v_pais' = 'UY'
   AND a.hea_upd_cellular_number_real = b.esc_clu_cellular_number(+)
   AND a.hea_upd_esn = b.esc_esn_hexa(+)
   AND a.itec_pos_code = c.pos_code(+)
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
         ,'comisiones_psr_C0025_01ab'
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