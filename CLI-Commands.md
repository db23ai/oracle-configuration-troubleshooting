# Alias and Commands Reference

## Aliases

- `o` : List the last 5 jobs using `odacli`
  ```bash
  alias o='odacli list-jobs | tail -5'
  ```

- `c` : Clear the terminal screen
  ```bash
  alias c='clear'
  ```

- `h` : Display command history
  ```bash
  alias h='history'
  ```

## Commands

### Create Database in ODA

Create a new database named `emma` with specific configurations:
```bash
odacli create-database -n emma -s odb1 -p pdb1 -r asm -c -y RAC -u emma_src -t -v 23.7.0.25.01
```

### ZDM Online Physical Migration

Perform an online physical migration of the database using `zdmcli`:
```bash
zdmcli migrate database -sourcedb emma_src -sourcenode servername -targetnode servername -srcauth zdmauth -srcarg1 user:oracle -srcarg2 identity_file:/home/zdmuser/.ssh/id_rsa -srcarg3 sudo_location:/usr/bin/sudo -tgtauth zdmauth -tgtarg1 user:oracle -tgtarg2 identity_file:/home/zdmuser/.ssh/id_rsa -tgtarg3 sudo_location:/usr/bin/sudo -rsp /home/zdmuser/emma_online_physical.rsp -tdekeystorepasswd -ignore PATCH_CHECK -eval
```

### Check Passwordless Connectivity

Verify passwordless SSH connectivity:
```bash
ssh -oStrictHostKeyChecking=no -i /home/zdmuser/.ssh/id_rsa oracle@orcl-ct2um1 "/usr/bin/sudo /bin/sh -c date"
```

### Remove TDE Wallet Files

Log in as the Oracle user and remove TDE wallet files:
```bash
/u01/app/oracle/product/23.0.0.0/dbhome_2/bin/asmcmd --privilege sysdba rm -rf +DATA/DBSYS_TGT/tde/ewallet.p12
/u01/app/oracle/product/23.0.0.0/dbhome_2/bin/asmcmd --privilege sysdba rm -rf +DATA/DBSYS_TGT/tde/cwallet.sso
```

### Copy Correct TDE Wallet Files

Log in as the Oracle user and copy the TDE wallet files:
```bash
/u01/app/oracle/product/23.0.0.0/dbhome_2/bin/asmcmd kscopy --local /u01/app/oracle/zdm/zdm_dbsys_tgt_3/zdm/TDE/ewallet.p12 +DATA/DBSYS_TGT/tde/
/u01/app/oracle/product/23.0.0.0/dbhome_2/bin/asmcmd kscopy --local /u01/app/oracle/zdm/zdm_dbsys_tgt_3/zdm/TDE/cwallet.sso +DATA/DBSYS_TGT/tde/
```

### Resize the ACFS Filesystem to 100 GB

Resize the ACFS filesystem to 200 GB:
```bash
[grid@servername ~]$ /sbin/acfsutil size 200G /dev/asm/acfsclone-445
```

Reference: [How To Resize An ACFS Filesystem/ASM Volume (ADVM) (Doc ID 1173978.1)](https://support.oracle.com)
