prompt ****************************************************************
prompt Archivo....: fi_zafra_pospago_3390_01a.sql
prompt Autor......: Leandro Mestrallet
prompt
prompt Descripción: Busco las migraciones prepago a pospago.
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
prompt Creando Tabla - AUX_3390_ZAFRA_POSP_01
prompt ****************************************************************
CREATE TABLE AUX_3390_ZAFRA_POSP_01 tablespace &V_TBS_ADMIN nologging pctfree 0 AS  
SELECT * FROM ( SELECT /*+ PARALLEL(A,4) PARALLEL(B,4)*/ 
                ANIO_MES,
                LINEA_CB,
                TRANSACTION_DATE,
                CELLULAR_NUMBER,
                B.CPL_ENT_ID ENTIDAD,
                '&V_ANIOMES_ACT' mes_zafra
                FROM &V_ESQUEMA_RAC8.CUSTOMER_BASE_NUEVO A
                    ,&V_ESQUEMA_RAC8.CELLULAR_PLANS B
                WHERE ANIO_MES = '&V_ANIOMES_ANT'
                  AND LINEA_CB = 'MIG_PP_A_REG'
                  AND B.CPL_RPL_ID(+) = A.RPL_ID
                  -- AND B.CPL_RPL_ID NOT LIKE 'INT%'
                  AND B.CPL_STG_ID = 'AH'
                  and (TO_CHAR (B.CPL_LAST_UPDATED_DATE,'YYYYMM') = '&V_ANIOMES_ANT'
                  or TO_CHAR (B.CPL_DUE_DATE,'YYYYMM') = '&V_ANIOMES_ANT')
                    -- and  TO_CHAR (B.cpl_start_date,'YYYYMM') >= '&V_ANIOMES_ANT'
                  AND B.CPL_CLU_CELLULAR_NUMBER (+) = A.CELLULAR_NUMBER
                  AND A.CLIENT_TYPE not in ('G','H','N','O','P','T')   
                  UNION ALL
                  SELECT /*+ PARALLEL(A,4) PARALLEL(B,4)*/ 
                ANIO_MES,
                LINEA_CB,
                TRANSACTION_DATE,
                CELLULAR_NUMBER,
                null ENTIDAD,
                '&V_ANIOMES_ACT' mes_zafra
                  FROM &V_ESQUEMA_RAC8.CUSTOMER_BASE_NUEVO A
                  WHERE ANIO_MES = '&V_ANIOMES_ANT'
                  AND LINEA_CB = 'MIG_PP_A_REG'
                  AND A.CLIENT_TYPE not in ('G','H','N','O','P','T')   
                  AND   CELLULAR_NUMBER not in (SELECT 
                                                  CELLULAR_NUMBER
                                                    FROM &V_ESQUEMA_RAC8.CUSTOMER_BASE_NUEVO A
                                                        ,&V_ESQUEMA_RAC8.CELLULAR_PLANS B
                                                  WHERE ANIO_MES = '&V_ANIOMES_ANT'
                                                    AND LINEA_CB = 'MIG_PP_A_REG'
                                                    AND B.CPL_RPL_ID(+) = A.RPL_ID
                                                    -- AND B.CPL_RPL_ID NOT LIKE 'INT%'
                                                    AND B.CPL_STG_ID = 'AH'
                                                    and (TO_CHAR (B.CPL_LAST_UPDATED_DATE,'YYYYMM') = '&V_ANIOMES_ANT'
                                                    or TO_CHAR (B.CPL_DUE_DATE,'YYYYMM') = '&V_ANIOMES_ANT')
                                                      -- and  TO_CHAR (B.cpl_start_date,'YYYYMM') >= '&V_ANIOMES_ANT'
                                                    AND B.CPL_CLU_CELLULAR_NUMBER (+) = A.CELLULAR_NUMBER
                                                    AND A.CLIENT_TYPE not in ('G','H','N','O','P','T'))
) 
/
select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') "Hora Fin" from dual
/
