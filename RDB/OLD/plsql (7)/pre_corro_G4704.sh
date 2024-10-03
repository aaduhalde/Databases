export ORACLE_SID=RAC8
export ORACLE_HOME=/oracle/app/oracle/product/12.1.0/client
export PATH=$ORACLE_HOME/bin:/usr/local/bin:/usr/bin:/opt/ansic/bin:/us:
export ORACLE_TERM=vt100
export TERM=vt100
echo `cat /exa1desa/desa/G4704/V10/pass_exc44585.txt`"
@/exa1desa/desa/G4704/V10/secuencia_G4704.sql" |sqlplus
