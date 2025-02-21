# Alias
alias o='odacli list-jobs | tail -5'

alias c='clear'

alias h='history'

# Create Database in ODA

odacli create-database -n emma -s odb1 -p pdb1 -r asm -c -y RAC -u emma_src -t -v 23.7.0.25.01

# ZDM Online Physical Migration

zdmcli migrate database -sourcedb emma_src -sourcenode servername -targetnode servername -srcauth zdmauth -srcarg1 user:oracle -srcarg2 
identity_file:/home/zdmuser/.ssh/id_rsa -srcarg3 sudo_location:/usr/bin/sudo -tgtauth zdmauth -tgtarg1 user:oracle -tgtarg2 
identity_file:/home/zdmuser/.ssh/id_rsa -tgtarg3 sudo_location:/usr/bin/sudo -rsp /home/zdmuser/emma_online_physical.rsp 
-tdekeystorepasswd -ignore PATCH_CHECK -eval

-- Check Passwordless connectivity

ssh -oStrictHostKeyChecking=no -i /home/zdmuser/.ssh/id_rsa oracle@orcl-ct2um1 "/usr/bin/sudo /bin/sh -c date"


# Remove TDE wallet files:

-- Login as Oracle user

/u01/app/oracle/product/23.0.0.0/dbhome_2/bin/asmcmd --privilege sysdba rm -rf +DATA/DBSYS_TGT/tde/ewallet.p12
/u01/app/oracle/product/23.0.0.0/dbhome_2/bin/asmcmd --privilege sysdba rm -rf +DATA/DBSYS_TGT/tde/cwallet.sso 

# Copy correct TDE wallet files:

-- Login as Oracle user

/u01/app/oracle/product/23.0.0.0/dbhome_2/bin/asmcmd kscopy --local /u01/app/oracle/zdm/zdm_dbsys_tgt_3/zdm/TDE/ewallet.p12 +DATA/DBSYS_TGT/tde/
/u01/app/oracle/product/23.0.0.0/dbhome_2/bin/asmcmd kscopy --local /u01/app/oracle/zdm/zdm_dbsys_tgt_3/zdm/TDE/cwallet.sso +DATA/DBSYS_TGT/tde/

# Resize the ACFS filesystem to 100 GB:
Reference - How To Resize An ACFS Filesystem/ASM Volume (ADVM) (Doc ID 1173978.1)

[root@servername ~]# df -h
Filesystem                             Size  Used Avail Use% Mounted on
/dev/md648p6                           488M  199M  254M  44% /boot
/dev/mapper/VolGroupSys-LogVolOpt       30G   16G   13G  56% /opt
/dev/mapper/VolGroupSys-LogVolU01       40G   14G   24G  38% /u01
/dev/asm/acfsclone-445                 150G  113G   38G  76% /opt/oracle/dbhome1

[grid@servername ~]$ /sbin/acfsutil size 200G /dev/asm/acfsclone-445
