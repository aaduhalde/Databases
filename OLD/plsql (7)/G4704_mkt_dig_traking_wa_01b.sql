PROMPT *********************************************************************
PROMPT  MKT_DIG_traking_wa
PROMPT *********************************************************************
PROMPT Archivo....: G4704_mkt_dig_traking_wa_01b.sql
PROMPT Autor......: Alejandro Duhalde
PROMPT Reviso.....:
PROMPT Produccion.:
PROMPT Descripcion: INSERTANDO DATOS En MKT_DIG_traking_wa
PROMPT *********************************************************************
PROMPT Seteos Iniciales
PROMPT *********************************************************************
SET timing ON
SET verify OFF
SET SERVEROUTPUT ON SIZE 10000
WHENEVER SQLERROR EXIT ROLLBACK
ALTER SESSION SET NLS_DATE_FORMAT='dd/mm/yyyy'
/
--TIEMPO INICIO
COLUMN val_0 new_value v_hora_inicio noprint
SELECT TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss') val_0
FROM DUAL
/





--PARAMETROS
PROMPT **********************************************************************
PROMPT Lectura de Parametros
PROMPT **********************************************************************

COLUMN val1 new_value v_esquema_rac8_1 noprint
SELECT 'EXC44585.' val1
FROM DUAL
/

COLUMN val2 new_value tabla_origen_1 noprint
SELECT 'aux1_traking_wa_G4704' val2
FROM DUAL
/

COLUMN val3 new_value espacio_tabla noprint
SELECT 'DEVELOP_AUX' val3
FROM DUAL
/

COLUMN val4 new_value tabla_destino_1    noprint
SELECT 'MKT_DIG_traking_wa' val4
FROM DUAL
/

PROMPT **********************************************************************
PROMPT Parametro: [ESQUEMA_RAC8_1]    - Valor: [&v_esquema_rac8_1]
PROMPT Parametro: [TABLA ORIGEN_1]    - Valor: [&tabla_origen_1]
PROMPT Parametro: [TABLA DESTINO_1]   - Valor: [&tabla_destino_1]
PROMPT Parametro: [espacio_tabla]     - Valor: [&espacio_tabla]
/

INSERT /*+ APPEND parallel(a,4) */ INTO &v_esquema_rac8_1.&tabla_destino_1 
(
TrackingType,
MID,
EID,
ContactKey,
MobileNumber,
EventDateUTC,
ChannelType,
AppID,
ChannelID,
ChannelName,
Status,
Reason,
JbDefinitionId,
JbActivityId,
SendIdentifier,
AssetId,
MessageTypeID
)
SELECT  /*+ PARALLEL(c,4) */  
TrackingType,
MID,
EID,
ContactKey,
MobileNumber,
EventDateUTC,
ChannelType,
AppID,
ChannelID,
ChannelName,
Status,
Reason,
JbDefinitionId,
JbActivityId,
SendIdentifier,
AssetId,
MessageTypeID
FROM  &v_esquema_rac8_1.&tabla_origen_1
/

COMMIT
/

--TIEMPO FIN
COLUMN val_100 new_value v_hora_fin noprint
SELECT TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss') val_100
FROM DUAL
/

PROMPT ************************************************* &v_hora_inicio : inicio Script
/
PROMPT ************************************************* &v_hora_fin : fin Script
/
