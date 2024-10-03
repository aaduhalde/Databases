prompt ****************************************************************
prompt Archivo....: fi_zafra_pospago_3390_01f.sql
prompt Autor......: Leandro Mestrallet
prompt
prompt Descripción: Armo la zafra de migraciones.
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
prompt ****************************************************************
prompt Creando Tabla - AUX_3390_ZAFRA_POSP_05
prompt ****************************************************************
CREATE TABLE AUX_3390_ZAFRA_POSP_05 tablespace &V_TBS_ADMIN nologging pctfree 0 AS  
SELECT /*+ PARALLEL(B,4) PARALLEL(A,4)*/
DISTINCT A.ANIO_MES, A.CELLULAR_NUMBER,CANAL, '&V_ANIOMES_ACT' MES_ZAFRA
  FROM B_FI_ZAFRA_MIG_POSP                 A,
       &V_ESQUEMA_RAC8.CONGELADA_CELLULARS PARTITION(CONG_CLU_&V_ANIOMES_ACT) B
 WHERE B.CELLULAR_NUMBER = A.CELLULAR_NUMBER
   AND B.SERVICE_STATUS = 'A'
   AND B.CALL_RESTRICTION_ID IN ('1', '2')
   AND A.TRANSACTION_DATE >= ADD_MONTHS(TO_DATE(&V_ANIOMES_ACT, 'YYYYMM'), -12) -->= TO_DATE('201510', 'YYYYMM')
   AND A.TRANSACTION_DATE < ADD_MONTHS(TO_DATE(&V_ANIOMES_ACT, 'YYYYMM'), 1)
 ORDER BY 1, 2
/
select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') "Hora Fin" from dual
/
