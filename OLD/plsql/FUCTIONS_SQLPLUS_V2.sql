--0DICSYS_DESA\8_G4713\FUCTIONS_SQLPLUS.sql
--C:\xampp\htdocs\0DICSYS_DESA\8_G4713\FUCTIONS_SQLPLUS.sql

cl scr


SELECT * FROM CAT
/


UNCTION f_genera_csv_ecommerce
(
    p_id_cursor   IN NUMBER,
    p_slc_reporte IN NUMBER,
    p_error_text  OUT VARCHAR2)
   --P_ID_CURSOR es el valor analizado para determinar que reporte debe armar

RETURN NUMBER IS


END FUNCTION f_genera_csv_ecommerce
/



 CASE P_ID_CURSOR
      WHEN 1 THEN

        BEGIN
          v_sentencia := 'Buscando WS_MAIL_TO...';
          SELECT MPR_VALUE
            INTO v_destinatarios
            FROM MAVERIC_PARAMETERS
           WHERE MPR_ID = 'WS_MAIL_TO';

          v_sentencia := 'Buscando WS_DIR_REPORTE...';
          SELECT MPR_VALUE
            INTO v_dir
            FROM MAVERIC_PARAMETERS
           WHERE MPR_ID = 'WS_DIR_REPORTE';

          v_sentencia := 'Buscando WS_MAIL_FROM...';
          SELECT MPR_VALUE
            INTO v_from
            FROM MAVERIC_PARAMETERS
           WHERE MPR_ID = 'WS_MAIL_FROM';



