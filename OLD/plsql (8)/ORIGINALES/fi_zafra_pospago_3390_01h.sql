prompt ****************************************************************
prompt Archivo....: fi_zafra_pospago_3390_01h.sql
prompt Autor......: Leandro Mestrallet
prompt
prompt Descripci�n: Actualizo tablas final resumen de migraciones.
prompt
prompt ****************************************************************
prompt Historia del Proceso
prompt
prompt Fecha 				Por 					Descripcion
prompt **********  *******    *********************************************
prompt 01/12/2016  L.Mestrallet  Creaci�n del script.
prompt ***************************************************************

prompt Seteos Iniciales
prompt ****************************************************************

@/racing/replica/seteos_iniciales.sql

select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') "Hora Inicio" from dual
/
prompt ****************************************************************
prompt Lectura de tablas de par�metros
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
prompt LIMPIA TABLA DE MIGRACIONES RESUMEN BS_FI_ZAFRA_POSP_MIG
prompt ****************************************************************
TRUNCATE TABLE BS_FI_ZAFRA_POSP_MIG
/
prompt ****************************************************************
prompt ACTUALIZA TABLA DE MIGRACIONES RESUMEN BS_FI_ZAFRA_POSP_MIG
prompt ****************************************************************
INSERT /*+ APPEND PARALLEL(b,4)*/
INTO BS_FI_ZAFRA_POSP_MIG
 (  
  ANIO_MES, 
	CANAL, 
	MES_1, 
	MES_2, 
	MES_3, 
	MES_4, 
	MES_5, 
	MES_6, 
	MES_7, 
	MES_8, 
	MES_9, 
	MES_10, 
	MES_11, 
	MES_12
 )
  SELECT 
ANIO_MES,
CASE
         WHEN CANAL NOT IN ('TELEMARKETING', '622', 'RECEPTIVA CACS','INDIRECTA') THEN 'OTROS'
         ELSE CANAL
END CANAL,
SUM(CASE WHEN TRUNC(MONTHS_BETWEEN(TO_DATE(MES_ZAFRA,'YYYYMM'),TO_DATE(ANIO_MES,'YYYYMM'))) = 1 THEN 1 END ) MES_1,
SUM(CASE WHEN TRUNC(MONTHS_BETWEEN(TO_DATE(MES_ZAFRA,'YYYYMM'),TO_DATE(ANIO_MES,'YYYYMM'))) = 2 THEN 1 END ) MES_2,
SUM(CASE WHEN TRUNC(MONTHS_BETWEEN(TO_DATE(MES_ZAFRA,'YYYYMM'),TO_DATE(ANIO_MES,'YYYYMM'))) = 3 THEN 1 END ) MES_3,
SUM(CASE WHEN TRUNC(MONTHS_BETWEEN(TO_DATE(MES_ZAFRA,'YYYYMM'),TO_DATE(ANIO_MES,'YYYYMM'))) = 4 THEN 1 END ) MES_4,
SUM(CASE WHEN TRUNC(MONTHS_BETWEEN(TO_DATE(MES_ZAFRA,'YYYYMM'),TO_DATE(ANIO_MES,'YYYYMM'))) = 5 THEN 1 END ) MES_5,
SUM(CASE WHEN TRUNC(MONTHS_BETWEEN(TO_DATE(MES_ZAFRA,'YYYYMM'),TO_DATE(ANIO_MES,'YYYYMM'))) = 6 THEN 1 END ) MES_6,
SUM(CASE WHEN TRUNC(MONTHS_BETWEEN(TO_DATE(MES_ZAFRA,'YYYYMM'),TO_DATE(ANIO_MES,'YYYYMM'))) = 7 THEN 1 END ) MES_7,
SUM(CASE WHEN TRUNC(MONTHS_BETWEEN(TO_DATE(MES_ZAFRA,'YYYYMM'),TO_DATE(ANIO_MES,'YYYYMM'))) = 8 THEN 1 END ) MES_8,
SUM(CASE WHEN TRUNC(MONTHS_BETWEEN(TO_DATE(MES_ZAFRA,'YYYYMM'),TO_DATE(ANIO_MES,'YYYYMM'))) = 9 THEN 1 END ) MES_9,
SUM(CASE WHEN TRUNC(MONTHS_BETWEEN(TO_DATE(MES_ZAFRA,'YYYYMM'),TO_DATE(ANIO_MES,'YYYYMM'))) = 10 THEN 1 END ) MES_10,
SUM(CASE WHEN TRUNC(MONTHS_BETWEEN(TO_DATE(MES_ZAFRA,'YYYYMM'),TO_DATE(ANIO_MES,'YYYYMM'))) = 11 THEN 1 END ) MES_11,
SUM(CASE WHEN TRUNC(MONTHS_BETWEEN(TO_DATE(MES_ZAFRA,'YYYYMM'),TO_DATE(ANIO_MES,'YYYYMM'))) = 12 THEN 1 END ) MES_12
FROM B_FI_ZAFRA_POSP_MIG
GROUP BY
ANIO_MES,
CASE
         WHEN CANAL NOT IN ('TELEMARKETING', '622', 'RECEPTIVA CACS','INDIRECTA') THEN 'OTROS'
         ELSE CANAL
       END 
ORDER BY 2,1
/
PROMPT ****************************************************************
PROMPT Actualizacion de tablas de actualizacion                                               
PROMPT ****************************************************************

UPDATE ACTUALIZACION_RACING 
SET ACT_OLD_DATE = ACT_ACTUALIZ_DATE,   
    ACT_ACTUALIZ_DATE = SYSDATE
WHERE ACT_TABLE_NAME= 'BS_FI_ZAFRA_POSP_MIG'
/
COMMIT
/
select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') "Hora Fin" from dual
/