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
PROMPT Archivo.................: comisiones_psr_C0025_01ac.sql
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
/*********************************************************************
              
              Descripcion del Script
              ----------------------
Se insertan los datos en las tablas finales

*********************************************************************/
PROMPT *******************************************************************Procesamiento
SET TIMING ON
PROMPT * * *  Borrando datos del proceso de la tabla DETAIL_FIRST_RECHARGE...
DECLARE
    v_fecha_ini DATE := TO_DATE('&v_fecha_proceso','dd/mm/yyyy');
    v_particion VARCHAR2(1000);
BEGIN
    v_particion :='ALTER TABLE DETAIL_FIRST_RECHARGE TRUNCATE PARTITION FOR(TO_DATE('''||TO_CHAR(v_fecha_ini,'dd/mm/yyyy')||''',''dd/mm/yyyy''))';
    DBMS_OUTPUT.put_line('Execute :'||v_particion);
    DECLARE
       partition_not_exist EXCEPTION;
       PRAGMA EXCEPTION_INIT(partition_not_exist, -2149);
    BEGIN
       EXECUTE IMMEDIATE v_particion; 
       DBMS_OUTPUT.put_line('Se trunco la partición : ' || TO_CHAR(v_fecha_ini,'dd/mm/yyyy') );
    EXCEPTION
       WHEN partition_not_exist THEN DBMS_OUTPUT.put_line('No existen particion para truncar');
    END;        
END;
/
PROMPT * * *  Borrando registros re-procesados de la tabla DETAIL_FIRST_RECHARGE...
DELETE /*+ parallel(a,4) */
      FROM  detail_first_recharge a
      WHERE EXISTS
               (SELECT 1
                  FROM aux_c0025_prim_rec_11 b
                 WHERE a.handle_cliente = b.handle)
/
COMMIT
/
PROMPT * * *  Insertando datos del proceso en la tabla DETAIL_FIRST_RECHARGE...
INSERT /*+ append parallel(a,4) */
      INTO  detail_first_recharge a(fecha_proceso
                                   ,cuenta
                                   ,nim_cliente
                                   ,handle_cliente
                                   ,sim_cliente
                                   ,nim_activacion
                                   ,fecha_activacion
                                   ,fecha_acreditacion_tn3
                                   ,fecha_acreditacion_pretups
                                   ,monto_recarga_tn3
                                   ,monto_recarga_pretups
                                   ,premio_acreditado
                                   ,pos_code
                                   ,nim_vendedor_sim
                                   ,promo
                                   ,fecha_alta_pos_code
                                   ,fecha_baja_pos_code
                                   ,categoria_nim_vendedor
                                   ,entidad_agente
                                   ,razon_social_agente
                                   ,provincia_itec
                                   ,provincia_param
                                   ,pais
                                   ,ss_vv_territorio
                                   ,rubro
                                   ,fecha_confirmacion_lote
                                   ,tipo_recarga
                                   ,id_transaccion_pretups
                                   ,modalidad_venta
                                   ,fecha_insercion
                                   ,give_commission
                                   ,destino_acreditacion
                                   ,nim_distribuidor)
   SELECT /*+ parallel(a,4) */
          fecha_proceso
         ,account_id
         ,cellular_number
         ,handle
         ,hea_upd_esn
         ,hea_upd_cellular_number_real
         ,hea_real_activation_date
         ,fecha_acreditacion_tn3
         ,fecha_acreditacion_pretups
         ,monto_recarga_tn3
         ,monto_recarga_pretups
         ,prt_comision_psr
         ,itec_pos_code
         ,moi_ussd
         ,promo
         ,itec_pos_start_date
         ,itec_pos_end_date
         ,sender_category
         ,itec_ent_id
         ,itec_ent_nombre_of
         ,provincia_itec
         ,provincia_param
         ,pais
         ,trr_ssvv
         ,itec_pot_name
         ,pri_delivered_date
         ,origen
         ,transfer_id
         ,request_gateway_type
         ,SYSDATE
         ,give_commission
         ,destino_acreditacion
         ,nim_distribuidor
     FROM aux_c0025_prim_rec_11 a
/
COMMIT
/
PROMPT * * *  Actualizando Diccionario de Datos...
UPDATE actualizacion_racing
   SET act_old_date = act_actualiz_date
      ,act_actualiz_date = sysdate
 WHERE act_procedure_name = 'COMISIONES_PSR'
   AND act_table_name = 'DETAIL_FIRST_RECHARGE'
/
COMMIT
/
PROMPT * * *  Borrando datos del proceso de la tabla DETAIL_FIRST_RECHARGE_RAW...
DECLARE
    v_fecha_ini DATE := TO_DATE('&v_fecha_proceso','dd/mm/yyyy');
    v_particion VARCHAR2(1000);
BEGIN
    v_particion :='ALTER TABLE DETAIL_FIRST_RECHARGE_RAW TRUNCATE PARTITION FOR(TO_DATE('''||TO_CHAR(v_fecha_ini,'dd/mm/yyyy')||''',''dd/mm/yyyy''))';
    DBMS_OUTPUT.put_line('Execute :'||v_particion);
    DECLARE
       partition_not_exist EXCEPTION;
       PRAGMA EXCEPTION_INIT(partition_not_exist, -2149);
    BEGIN
       EXECUTE IMMEDIATE v_particion; 
       DBMS_OUTPUT.put_line('Se trunco la partición : ' || TO_CHAR(v_fecha_ini,'dd/mm/yyyy') );
    EXCEPTION
       WHEN partition_not_exist THEN DBMS_OUTPUT.put_line('No existen particion para truncar');
    END;        
END;
/
PROMPT * * *  Borrando registros re-procesados de la tabla DETAIL_FIRST_RECHARGE_RAW...
DELETE /*+ parallel(a,4) */
      FROM  detail_first_recharge_raw a
      WHERE EXISTS
               (SELECT 1
                  FROM aux_c0025_prim_rec_11 b
                 WHERE a.pce_handle = b.handle)
/
COMMIT
/
PROMPT * * *  Insertando datos del proceso en la tabla DETAIL_FIRST_RECHARGE_RAW...
INSERT /*+ append parallel(a,4) */
      INTO  detail_first_recharge_raw a(fecha_proceso
                                       ,pce_handle
                                       ,pce_clu_cellular_number
                                       ,srf_account_number
                                       ,nim_activacion
                                       ,srf_activation_date
                                       ,pce_last_recharge_date
                                       ,pce_hist_recharge_counter
                                       ,esc_esn_hexa
                                       ,esc_start_date
                                       ,esc_end_date
                                       ,gsm_date
                                       ,gsm_origen
                                       ,gsm_recarga
                                       ,prt_transfer_id
                                       ,prt_request_gateway_type
                                       ,prt_transferdatetime
                                       ,prt_network_code
                                       ,prt_sender_msisdn
                                       ,prt_sender_category
                                       ,prt_receiver_msisdn
                                       ,prt_quantity
                                       ,prt_comision_psr
                                       ,itec_pri_id
                                       ,itec_pri_start_date
                                       ,itec_pri_end_date
                                       ,itec_pri_serie
                                       ,itec_pri_delivered_date
                                       ,itec_pos_code
                                       ,itec_pos_start_date
                                       ,itec_pos_end_date
                                       ,itec_pos_name
                                       ,itec_posp_nim
                                       ,itec_pot_name
                                       ,provincia_itec
                                       ,provincia_param
                                       ,pais
                                       ,itec_trr_ssv
                                       ,itec_ent_id
                                       ,itec_ent_nombre_of
                                       ,srf_spn_spc_id
                                       ,fecha_insert)
   SELECT /*+ parallel(a,4) */
          fecha_proceso
         ,handle
         ,cellular_number
         ,account_id
         ,hea_upd_cellular_number_real
         ,hea_real_activation_date
         ,pce_last_recharge_date
         ,pce_hist_recharge_counter
         ,esc_esn_hexa
         ,esc_start_date
         ,esc_end_date
         ,fecha_recarga
         ,origen
         ,monto_recarga_tn3
         ,transfer_id
         ,request_gateway_type
         ,fecha_acreditacion_pretups
         ,CAST('&v_pais' AS VARCHAR2(2))
         ,moi_ussd
         ,sender_category
         ,cellular_number
         ,monto_recarga_pretups
         ,prt_comision_psr
         ,pri_id
         ,pri_start_date
         ,pri_end_date
         ,pri_serie
         ,pri_delivered_date
         ,itec_pos_code
         ,itec_pos_start_date
         ,itec_pos_end_date
         ,itec_pos_name
         ,itec_posp_nim
         ,itec_pot_name
         ,provincia_itec
         ,provincia_param
         ,pais
         ,trr_ssvv
         ,itec_ent_id
         ,itec_ent_nombre_of
         ,promo
         ,SYSDATE
     FROM aux_c0025_prim_rec_11 a
/
COMMIT
/
PROMPT * * *  Actualizando Diccionario de Datos...
UPDATE actualizacion_racing
   SET act_old_date = act_actualiz_date
      ,act_actualiz_date = sysdate
 WHERE act_procedure_name = 'COMISIONES_PSR'
   AND act_table_name = 'DETAIL_FIRST_RECHARGE_RAW'
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
         ,'comisiones_psr_C0025_01ac'
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