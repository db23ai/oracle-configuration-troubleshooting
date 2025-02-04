# Alias
alias o='odacli list-jobs | tail -5'

alias c='clear'

alias h='history'

# Remove TDE wallet files:

-- Login as Oracle user

/u01/app/oracle/product/23.0.0.0/dbhome_2/bin/asmcmd --privilege sysdba rm -rf +DATA/DBSYS_TGT/tde/ewallet.p12
/u01/app/oracle/product/23.0.0.0/dbhome_2/bin/asmcmd --privilege sysdba rm -rf +DATA/DBSYS_TGT/tde/cwallet.sso 

# Copy correct TDE wallet files:

-- Login as Oracle user

/u01/app/oracle/product/23.0.0.0/dbhome_2/bin/asmcmd kscopy --local /u01/app/oracle/zdm/zdm_dbsys_tgt_3/zdm/TDE/ewallet.p12 +DATA/DBSYS_TGT/tde/
/u01/app/oracle/product/23.0.0.0/dbhome_2/bin/asmcmd kscopy --local /u01/app/oracle/zdm/zdm_dbsys_tgt_3/zdm/TDE/cwallet.sso +DATA/DBSYS_TGT/tde/
