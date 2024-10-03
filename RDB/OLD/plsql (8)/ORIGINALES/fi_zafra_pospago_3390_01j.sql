prompt ****************************************************************
prompt Archivo....: fi_zafra_pospago_3390_01j.sql
prompt Autor......: Leandro Mestrallet
prompt
prompt Descripción: Actualizo tabla final de activaciones.
prompt
prompt ****************************************************************
prompt Historia del Proceso
prompt
prompt Fecha 				Por 					Descripcion
prompt **********  *******    *********************************************
prompt 01/12/2016  L.Mestrallet  Creación del script.
prompt ***************************************************************

prompt Seteos Iniciales
prompt ****************************************************************

@/racing/replica/seteos_iniciales.sql

select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') "Hora Inicio" from dual
/
prompt ****************************************************************
prompt Lectura de tablas de parámetros
prompt ****************************************************************

COL PAIS NEW_VALUE V_PAIS    NOPRINT 
COL ESQUEMA_RAC8 NEW_VALUE V_ESQUEMA_RAC8         NOPRINT
COL TBS_ADMIN NEW_VALUE V_TBS_ADMIN               NOPRINT
SELECT pck_core.fc_get_parameter('CORE','PAIS') PAIS,
	     pck_core.fc_get_parameter ('CORE', 'ESQUEMA_RAC8') ESQUEMA_RAC8,
	     pck_core.fc_get_parameter ('CORE', 'TBS_ADMIN') TBS_ADMIN
FROM DUAL
/
COL FECHA_DESDE    new_value V_ANIOMES_ANT noprint
  SELECT nvl(PAR_VALUE_VARCHAR2, to_char(add_months(sysdate, -2), 'YYYYMM')) FECHA_DESDE
    from PARAM_ACTUALIZ_RACING
   WHERE PAR_PROCEDURE_NAME = 'G3390_ZAFRA_POSPAGO'
     AND PAR_PARAMETER_NAME = 'ANIOMES_ANT'
/
COL FECHA_HASTA    new_value V_ANIOMES_ACT noprint
  SELECT nvl(PAR_VALUE_VARCHAR2, to_char(add_months(sysdate, -1), 'YYYYMM')) FECHA_HASTA
    from PARAM_ACTUALIZ_RACING
   WHERE PAR_PROCEDURE_NAME = 'G3390_ZAFRA_POSPAGO'
     AND PAR_PARAMETER_NAME = 'ANIOMES_ACT'
/
prompt ****************************************************************
prompt Parametros
prompt ****************************************************************
prompt Parametro 1: [PAIS]                    - Valor: [&V_PAIS]
prompt Parametro 2: [ESQUEMA_RAC8]            - Valor: [&V_ESQUEMA_RAC8]
prompt Parametro 3: [TBS_ADMIN]               - Valor: [&V_TBS_ADMIN]
prompt Parametro 4: [ANIOMES_ANT]          		- Valor: [&V_ANIOMES_ANT]
prompt Parametro 5: [ANIOMES_ACT]           	- Valor: [&V_ANIOMES_ACT]
prompt ****************************************************************
prompt ELIMINA DATOS DE B_FI_ZAFRA_ACT_POSP POR REPROCESO
prompt ****************************************************************
DECLARE
  partition_not_exist EXCEPTION;
  PRAGMA EXCEPTION_INIT(partition_not_exist, -2149);

  fecha DATE := TO_DATE('&V_ANIOMES_ANT', 'yyyymm');

BEGIN
  dbms_output.put_line('alter table B_FI_ZAFRA_ACT_POSP truncate partition for (to_date(''' ||
                       to_char(fecha, 'dd/mm/yyyy') ||
                       ''',''dd/mm/yyyy''))');
  execute immediate 'alter table B_FI_ZAFRA_ACT_POSP truncate partition for (to_date(''' ||
                    to_char(fecha, 'dd/mm/yyyy') || ''',''dd/mm/yyyy''))';
EXCEPTION
  when partition_not_exist then
    dbms_output.put_line('No existe la particion del dia ' ||
                         to_char(fecha, 'dd/mm/yyyy'));
END;
/
prompt ****************************************************************
prompt ACTUALIZA TABLA DE ACTIVACIONES B_FI_ZAFRA_ACT_POSP
prompt ****************************************************************
INSERT /*+ APPEND PARALLEL(b,4) */ 
INTO B_FI_ZAFRA_ACT_POSP
(
FECHA,
ORIGEN, 
PROMO, 
ANIO_MES, 
TRANSACTION_DATE, 
CELLULAR_NUMBER, 
ACTIVATION_DATE, 
ACCOUNT_ID, 
CLIENT_ID, 
CONTRACT_TYPE_ID, 
DEALER_ID, 
CANAL, 
OFICINA, 
RAZ_SOC
) 
SELECT 
TO_DATE(ANIO_MES,'YYYYMM'),
ORIGEN, 
PROMO, 
ANIO_MES, 
TRANSACTION_DATE, 
CELLULAR_NUMBER, 
ACTIVATION_DATE, 
ACCOUNT_ID, 
CLIENT_ID, 
CONTRACT_TYPE_ID, 
DEALER_ID, 
CANAL, 
OFICINA, 
RAZ_SOC
FROM AUX_3390_ZAFRA_POSP_06
/
PROMPT ****************************************************************
PROMPT Actualizacion de tablas de actualizacion                                               
PROMPT ****************************************************************

UPDATE ACTUALIZACION_RACING 
SET ACT_OLD_DATE = ACT_ACTUALIZ_DATE,   
    ACT_ACTUALIZ_DATE = SYSDATE
where ACT_TABLE_NAME= 'B_FI_ZAFRA_ACT_POSP'
/
COMMIT
/
select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') "Hora Fin" from dual
/