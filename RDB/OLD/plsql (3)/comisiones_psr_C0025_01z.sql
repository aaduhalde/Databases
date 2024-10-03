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
PROMPT Archivo.................: comisiones_psr_C0025_01z.sql
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
       Parametro: Rubro
*/
COLUMN parametro format a20
COLUMN v_10 new_value v_rubro format a20 PRINT
SELECT RPAD( 'RUBRO', 20, '.') parametro
      ,par_value_varchar2 v_10
  FROM param_actualiz_racing
 WHERE par_procedure_name = 'COMISIONES_PSR'
   AND par_parameter_name = 'RUBRO'
/
---------------------------------------------------------------------------------------
/*
       Parametro: Monto por defecto a liquidar
*/
COLUMN parametro format a20
COLUMN v_11 new_value v_monto format 999999 PRINT
SELECT RPAD( 'MONTO', 20, '.') parametro
      ,par_value_number v_11
  FROM param_actualiz_racing
 WHERE par_procedure_name = 'COMISIONES_PSR'
   AND par_parameter_name = 'MONTO'
/
---------------------------------------------------------------------------------------
/*
       Parametro: Monto por defecto a liquidar para los que no son 4x4
*/
COLUMN parametro format a20
COLUMN v_17 new_value v_monto_2 format 999999 PRINT
SELECT RPAD( 'MONTO_NO_4X4', 20, '.') parametro
      ,par_value_number v_17
  FROM param_actualiz_racing
 WHERE par_procedure_name = 'COMISIONES_PSR'
   AND par_parameter_name = 'MONTO_NO_4X4'
/
/*********************************************************************
              
              Descripcion del Script
              ----------------------
Se calcula la comision a pagar

*********************************************************************/
PROMPT *******************************************************************Procesamiento
PROMPT * * *  Creando la AUX_C0025_PRIM_REC_10...
SET TIMING ON
CREATE TABLE AUX_C0025_PRIM_REC_10
TABLESPACE &v_tbs_admin
NOLOGGING
AS
SELECT /*+ parallel(a,4) parallel(b,4) */
       a.fecha_proceso
      ,a.fecha_acreditacion_tn3
      ,a.fecha_acreditacion_pretups
      ,a.fecha_recarga
      ,a.monto_recarga_tn3
      ,a.monto_recarga_pretups
      ,a.monto
      ,a.cellular_number
      ,a.account_id
      ,a.handle
      ,a.hea_upd_esn
      ,a.hea_real_activation_date
      ,a.hea_upd_cellular_number_real
      ,a.promo
      ,a.origen
      ,a.pri_id
      ,CAST(a.pri_start_date AS DATE) pri_start_date
      ,CAST(a.pri_end_date AS DATE) pri_end_date
      ,a.pri_serie
      ,CAST(a.pri_delivered_date AS DATE) pri_delivered_date
      ,a.pri_pos_id
      ,a.itec_pos_code
      ,CAST(a.itec_pos_start_date AS DATE) itec_pos_start_date
      ,CAST(a.itec_pos_end_date AS DATE) itec_pos_end_date
      ,a.itec_pos_name
      ,a.itec_posp_nim
      ,a.itec_pot_name
      ,UPPER(b.provincia) provincia_param
      ,UPPER(a.provincia) provincia_itec
      ,UPPER(a.pais_param) pais
      ,a.trr_ssvv
      ,a.itec_ent_id
      ,a.itec_ent_nombre_of
      ,a.transfer_id
      ,a.request_gateway_type
      ,a.sender_category
      ,a.pce_last_recharge_date
      ,a.pce_hist_recharge_counter
      ,DECODE(pais_param,'ARGENTINA',CEIL(  
            CASE 
            WHEN monto <> 0 AND itec_pot_name NOT IN ('&v_rubro') AND (monto * COALESCE(inc_agente/100, inc_prov/100, inc_pais/100) > TO_NUMBER('&v_monto_2'))  THEN TO_NUMBER('&v_monto_2')
            WHEN monto <> 0 AND itec_pot_name NOT IN ('&v_rubro') AND (monto * COALESCE(inc_agente/100, inc_prov/100, inc_pais/100) <= TO_NUMBER('&v_monto_2')) THEN monto * COALESCE(inc_agente/100, inc_prov/100, inc_pais/100)
            WHEN monto <> 0 AND itec_pot_name     IN ('&v_rubro') AND (monto * COALESCE(inc_agente/100, inc_prov/100, inc_pais/100) > TO_NUMBER('&v_monto'))    THEN TO_NUMBER('&v_monto')
            WHEN monto <> 0 AND itec_pot_name     IN ('&v_rubro') AND (monto * COALESCE(inc_agente/100, inc_prov/100, inc_pais/100) <= TO_NUMBER('&v_monto'))   THEN monto * COALESCE(inc_agente/100, inc_prov/100, inc_pais/100)
            ELSE 0
            END) ,'URUGUAY'  ,CEIL(monto * COALESCE(inc_agente/100, inc_prov/100, inc_pais/100))) prt_comision_psr
      ,a.row_id_dfr
      ,a.row_id_dfrr
  FROM aux_c0025_prim_rec_09 a
      ,incentivos_sellout b
 WHERE a.provincia = b.provincia(+)
   AND a.pais_param = b.pais(+)
   AND a.itec_ent_id = b.nro_agente(+)
   AND a.fecha_proceso+1 >= NVL(b.fecha_desde, TO_DATE('01/01/1900','dd/mm/yyyy'))
   AND a.fecha_proceso+1 < NVL(b.fecha_hasta, TO_DATE('31/12/3999','dd/mm/yyyy'))
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
         ,'comisiones_psr_C0025_01z'
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