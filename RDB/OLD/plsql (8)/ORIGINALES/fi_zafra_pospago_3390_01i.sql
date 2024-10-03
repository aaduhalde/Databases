prompt ****************************************************************
prompt Archivo....: fi_zafra_pospago_3390_01i.sql
prompt Autor......: Leandro Mestrallet
prompt
prompt Descripción: Clasifico las activaciones.
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
COL RSN_ACTIV    new_value V_RSN_ACTIV noprint
  SELECT PAR_VALUE_VARCHAR2 RSN_ACTIV
    from PARAM_ACTUALIZ_RACING
   WHERE PAR_PROCEDURE_NAME = 'G3390_ZAFRA_POSPAGO'
     AND PAR_PARAMETER_NAME = 'RSN_ACTIV'  /*AR in ('MOVI','NEXTEL','PERS') - PY --> IN ('TIGO', 'VOX', 'PERS') - UY IN ('')*/
/
prompt ****************************************************************
prompt Parametros
prompt ****************************************************************
prompt Parametro 1: [PAIS]                    - Valor: [&V_PAIS]
prompt Parametro 2: [ESQUEMA_RAC8]            - Valor: [&V_ESQUEMA_RAC8]
prompt Parametro 3: [TBS_ADMIN]               - Valor: [&V_TBS_ADMIN]
prompt Parametro 4: [ANIOMES_ANT]          		- Valor: [&V_ANIOMES_ANT]
prompt Parametro 5: [ANIOMES_ACT]           	- Valor: [&V_ANIOMES_ACT]
prompt Parametro 6: [RSN_ACTIV]           	  - Valor: [&V_RSN_ACTIV]
prompt ****************************************************************
prompt Creando Tabla - AUX_3390_ZAFRA_POSP_06
prompt ****************************************************************
CREATE TABLE AUX_3390_ZAFRA_POSP_06 tablespace &V_TBS_ADMIN nologging pctfree 0 AS
         SELECT /*+ PARALLEL(D,4) PARALLEL(A,4)*/ 
                CASE WHEN D.RSN_ACTIVATION &V_RSN_ACTIV THEN 'PORTIN' ELSE 'CLARO' END ORIGEN,
                CASE WHEN A.CONTRACT_TYPE_ID = 'PROP' THEN 'SIM SUELTA' ELSE 'NO SIM SUELTA' END PROMO,
                A.ANIO_MES,
                A.TRANSACTION_DATE,
                NVL(C.CELLULAR_NUMBER_AFTER, C.CELLULAR_NUMBER) CELLULAR_NUMBER,
                A.ACTIVATION_DATE,
                A.ACCOUNT_ID,
                A.CLIENT_ID,
                A.CONTRACT_TYPE_ID,
                A.DEALER_ID,
                B.CANAL,
                B.OFICINA,
                B.RAZ_SOC
           FROM &v_ESQUEMA_RAC8.CUSTOMER_BASE_REAL  A,
                &v_ESQUEMA_RAC8.PDVENTAS_GENERAL    B,
                &v_ESQUEMA_RAC8.CONGELADA_CELLULARS PARTITION(CONG_CLU_&V_ANIOMES_ANT) C,
                &v_ESQUEMA_RAC8.CONGELADA_CELLULARS PARTITION(CONG_CLU_&V_ANIOMES_ANT) D,                                     
                &v_ESQUEMA_RAC8.RATE_PLANS          E  -- Cambio Alias!!!
          WHERE A.ANIO_MES = '&V_ANIOMES_ANT'
            AND B.DEALER_ID (+) = A.DEALER_ID
            AND C.CELLULAR_NUMBER = A.CELLULAR_NUMBER
            AND A.LINEA_CB IN ('REG_ACTIV_ORIG', 'REG_ACTIV_PROV_MIG', 'REG_ALTAS_CIA', 'REG_ALTAS_PLAN_VL')--*/LIKE 'REG_ACTIV%' -- CAMBIO!!!
            AND E.RPL_ID = A.RPL_ID                                                                                               -- Cambio Alias!!!
            AND E.RPL_RTY_ID NOT LIKE 'INT%' --VOZ!!!                                                                             -- Cambio Alias!!!
            AND A.CLIENT_TYPE not in ('N','O','T','G','H','P') -- MASIVO!!!
            AND A.CBT_ID in ('CO','CR','CP')                                                                                       -- Nuevo!!!
            AND NVL(C.CELLULAR_NUMBER_AFTER, C.CELLULAR_NUMBER) = D.CELLULAR_NUMBER
/
select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') "Hora Fin" from dual
/
