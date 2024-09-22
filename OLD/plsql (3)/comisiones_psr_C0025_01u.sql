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
PROMPT Archivo.................: comisiones_psr_C0025_01u.sql
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
/*********************************************************************
              
              Descripcion del Script
              ----------------------
Se buscan en diferentes tablas, los datos de los POS y se normalizan
otros datos

*********************************************************************/
PROMPT *******************************************************************Procesamiento
PROMPT * * *  Creando la AUX_C0025_PROD_ITEMS_03...
SET TIMING ON
CREATE TABLE AUX_C0025_PROD_ITEMS_03
TABLESPACE &v_tbs_admin
NOLOGGING
AS
SELECT /*+ parallel(b,4) parallel(c,4) parallel(d,4) parallel(e,4) */
       b.id pos_id
      ,b.pos_code itec_pos_code
      ,b.start_date itec_pos_start_date
      ,b.end_date itec_pos_end_date
      ,b.pos_name itec_pos_name
      ,c.posp_nim itec_posp_nim
      ,d.pot_name itec_pot_name
      ,UPPER(TRANSLATE(
                  TRANSLATE(
                             TRANSLATE(
                                        TRANSLATE(
                                                   TRANSLATE(
                                                              TRANSLATE(e.add_state, 'Ò—·ÈÌÛ˙‡ËÏÚ˘„ı‚ÍÓÙ˚‰ÎÔˆ¸Á¡…Õ”⁄¿»Ã“Ÿ√’¬ Œ‘€ƒÀœ÷‹«-,+*[]®_∞|~`./()<>ø?', 'nNaeiouaeiouaoaeiouaeioucAEIOUAEIOUAOAEIOUAEIOUC                    ')
                                                             ,CHR(233)
                                                             ,'e'
                                                            )
                                                  ,CHR(243)
                                                  ,'o'
                                                 )
                                       ,CHR(225)
                                       ,'a'
                                      )
                            ,CHR(237)
                            ,'i')
                 ,CHR(250)
                 ,'u'
                )) provincia
      ,UPPER(TRANSLATE(
                  TRANSLATE(
                             TRANSLATE(
                                        TRANSLATE(
                                                   TRANSLATE(
                                                              TRANSLATE(e.add_country, 'Ò—·ÈÌÛ˙‡ËÏÚ˘„ı‚ÍÓÙ˚‰ÎÔˆ¸Á¡…Õ”⁄¿»Ã“Ÿ√’¬ Œ‘€ƒÀœ÷‹«-,+*[]®_∞|~`./()<>ø?', 'nNaeiouaeiouaoaeiouaeioucAEIOUAEIOUAOAEIOUAEIOUC                    ')
                                                             ,CHR(233)
                                                             ,'e'
                                                            )
                                                  ,CHR(243)
                                                  ,'o'
                                                 )
                                       ,CHR(225)
                                       ,'a'
                                      )
                            ,CHR(237)
                            ,'i'
                           )
                 ,CHR(250)
                 ,'u'
                )) pais_itec
      ,DECODE('&v_pais','AR','ARGENTINA','UY','URUGUAY') pais_param
      ,b.pos_terr_id
  FROM &v_esquema_rac8.itec_points_of_sales b
      ,aux_c0025_prod_items_02 c
      ,&v_esquema_rac8.itec_points_of_sales_types d
      ,&v_esquema_rac8.itec_addresses e
 WHERE b.id = c.posp_pos_id(+)
   AND b.pos_type_id = d.id(+)
   AND b.pos_add_id = e.add_id(+)
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
         ,'comisiones_psr_C0025_01u'
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