# Zero Downtime Migration (ZDM) Software Uninstallation Guide

## Step-by-Step Instructions

### 1. Connect to the Linux Host

Connect as the user with which you want to uninstall the Zero Downtime Migration (ZDM) software.

### 2. Locate the `zdmservice` File

Use the `locate` command to find the `zdmservice`.

```bash
[zdmuser@servername ~]$ locate zdmservice 
/u01/app/zdmhome/bin/zdmservice
```

### 3. Stop the Zero Downtime Migration Service

Run the following command to stop the ZDM service:

```bash
[zdmuser@servername ~]$ /u01/app/zdmhome/bin/zdmservice stop
```

#### Example Output

```plaintext
spawn /u01/app/zdmhome/mysql/server/bin/mysqladmin --defaults-file=/u01/app/zdmbase/crsdata/servername/rhp/conf/my.cnf -u root -p shutdown
WARNING: oracle.jwc.jmx does not exist in the configuration file. It will be TRUE by default.
[jwcctl debug] Environment ready to start JWC
[jwcctl debug] Return code of initialization: [0]

[jwcctl debug] ... BEGIN_DEBUG [Action= stop] ...
Stop JWC
[jwcctl debug] Get JWC PIDs
[jwcctl debug] Done Getting JWC PIDs
[jwcctl debug] ... JWC Container (pid=128735) ...
[jwcctl debug]     Stop command:-Dcatalina.base=/u01/app/zdmbase/crsdata/servername/rhp -Doracle.tls.enabled=false -Doracle.wlm.dbwlmlogger.logging.level=FINEST -Doracle.jwc.client.logger.file.name=/u01/app/zdmbase/crsdata/servername/rhp/logs/jwc_shutter_stdout_err_%g.log -Doracle.jwc.client.logger.file.number=10 -Doracle.jwc.client.logger.file.size=1048576 -Doracle.jwc.wallet.path=/u01/app/zdmbase/crsdata/servername/security -Doracle.jmx.login.credstore=WALLET -classpath /u01/app/zdmhome/jlib/jwc-logging.jar:/u01/app/zdmhome/jlib/jwc-client.jar:/u01/app/zdmhome/jlib/jwc-security.jar:/u01/app/zdmhome/jdk/lib/tools.jar:/u01/app/zdmhome/tomcat/lib/tomcat-juli.jar oracle.cluster.jwc.tomcat.client.ShutdownContainer 128735
[jwcctl debug] Get JWC shutter PIDs
[jwcctl debug] Done getting JWC shutter PIDs
[jwcctl debug] ... JWC shutter command (pid=251033) ...
[jwcctl debug] ... Initial Check - JWC Shutter JVM waiting (pid=251033) ...
[jwcctl debug] ... Sleep for 1 seconds ...
[jwcctl debug] ... Iteration 0 Check for JWC Shutter ...
[jwcctl debug] Get JWC shutter PIDs
[jwcctl debug] Done getting JWC shutter PIDs
[jwcctl debug] ... JWC shutter command not found ...
[jwcctl debug] ... Iteration 0 Check for JWC Container ...
[jwcctl debug] Get JWC PIDs
[jwcctl debug] Done Getting JWC PIDs
[jwcctl debug] ... JWC containers not found ...
[jwcctl debug] ... JWC Container is stopped ...
[jwcctl debug] ... STOP - Return code = 0 ...
[jwcctl debug]  ... END_DEBUG [Action=stop] ...
[jwcctl debug] Return code of AGENT: [0]

Return code is 0
zdmservice stopped successfully.
```

### 4. Uninstall the Zero Downtime Migration Software

Run the following command to uninstall the software:

```bash
[zdmuser@servername ~]$ /u01/app/zdmhome/bin/zdmservice stop deinstall
```

#### Example Output

```plaintext
---------------------------------------
Running deinstall steps ...
---------------------------------------
DB_TYPE is: MYSQL
update is: 
cleanup is: 0
Confirm you want to deinstall [y/N]: y
Executing detachHome...
Starting Oracle Universal Installer...

Checking swap space: must be greater than 500 MB.   Actual 16139 MB    Passed
The inventory pointer is located at /u01/app/zdmhome/oraInst.loc
You can find the log of this install session at:
 /u01/app/zdmhome/inventory/logs/DetachHome2025-01-28_01-11-03AM.log
'DetachHome' was successful.
Deleting oracle base folder
Deleting oracle home folder
Deinstall finished successfully
```
