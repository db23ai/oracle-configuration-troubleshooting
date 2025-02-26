# Patching Oracle Database Appliance DB Systems via Command-Line

## Prerequisites
- Oracle Database clone files must be available in the repository.

## Steps

### 1. List Available Patches
```
odacli list-availablepatches
```
Example:
```
[root@servername~]# odacli list-availablepatches

ODA Release Version Supported DB Versions Available DB Versions Supported Platforms
------------------- ----------------- ------------------ -------------------
19.25.0.0.0         23.7.0.25.01      Clone not available DB System
21.8.0.0.221018     Clone not available DB System
19.25.0.0.250121    19.25.0.0.250121  Bare Metal, DB System
```

### 2. Connect to the DB System and Update DCS Admin
```
/opt/oracle/dcs/bin/odacli update-dcsadmin -v 19.25.0.0.0
```
Example:
```
[root@servername ~]# /opt/oracle/dcs/bin/odacli update-dcsadmin -v 19.25.0.0.0 
{ 
  "jobId" : "9bef3e54-34e3-4641-bcd8-183a9b184f8d", 
  "status" : "Created", 
  "message" : "", 
  "reports" : [ ], 
  "createTimestamp" : "February 03, 2025 05:40:39 AM CET", 
  "resourceList" : [ ], 
  "description" : "DcsAdmin patching", 
  "updatedTime" : "February 03, 2025 05:40:39 AM CET", 
  "jobType" : null, 
  "cpsMetadata" : null 
}
```

### 3. Check Job Status
```
odacli describe-job -i 9bef3e54-34e3-4641-bcd8-183a9b184f8d
```
Example:
```
[root@servername ~]# odacli describe-job -i 9bef3e54-34e3-4641-bcd8-183a9b184f8d
Job details

ID:  9bef3e54-34e3-4641-bcd8-183a9b184f8d
Description:  DcsAdmin patching
Status:  Success
Created:  February 03, 2025 05:40:39 CET
Message:  
```

### 4. Update the DCS Components
```
/opt/oracle/dcs/bin/odacli update-dcscomponents -v 19.25.0.0.0
```
Example:
```
[root@servername ~]# /opt/oracle/dcs/bin/odacli update-dcscomponents -v 19.25.0.0.0 
{ 
  "jobId" : "1c6408df-71a3-4ff1-a5b5-4bf731196480", 
  "status" : "Success", 
  "message" : "Update-dcscomponents is successful on all the node(s): DCS-Agent shutdown is successful. MySQL upgrade is successful. Metadata schema update is done. Modified metadata.dcsagent RPM upgrade is successful. dcscli RPM upgrade is successful. dcscontroller RPM upgrade is successful. Successfully reset the Keystore password. HAMI RPM is already updated. Removed old Libs Successfully ran setupAgentAuth.sh ", 
  "reports" : null, 
  "createTimestamp" : "February 03, 2025 05:47:36 AM CET", 
  "description" : "Update-dcscomponents job completed and is not part of Agent job list", 
  "updatedTime" : "February 03, 2025 05:54:44 AM CET", 
  "jobType" : null 
}
```

### 5. Update the DCS Agent
```
/opt/oracle/dcs/bin/odacli update-dcsagent -v 19.25.0.0.0
```
Example:
```
[root@servername ~]# /opt/oracle/dcs/bin/odacli update-dcsagent -v 19.25.0.0.0 
{ 
  "jobId" : "b1c84c7a-1853-49ef-8732-1a7bc0d982f2", 
  "status" : "Created", 
  "message" : "", 
  "reports" : [ ], 
  "createTimestamp" : "February 03, 2025 06:04:44 AM CET", 
  "resourceList" : [ ], 
  "description" : "DcsAgent patching to 19.25.0.0.0", 
  "updatedTime" : "February 03, 2025 06:04:44 AM CET", 
  "jobType" : null, 
  "cpsMetadata" : null 
}
```

### 6. Check Job Status
```
odacli describe-job -i b1c84c7a-1853-49ef-8732-1a7bc0d982f2
```
Example:
```
[root@servername ~]# odacli describe-job -i b1c84c7a-1853-49ef-8732-1a7bc0d982f2
Job details

ID:  b1c84c7a-1853-49ef-8732-1a7bc0d982f2
Description:  DcsAgent patching to 19.26.0.0.0
Status:  Success
Created:  February 03, 2025 06:04:44 CET
Message:  
```

### 7. Patching Pre-checks
```
/opt/oracle/dcs/bin/odacli create-prepatchreport -s -v 19.25.0.0.0
```
Example:
```
[root@servername ~]# odacli describe-prepatchreport -i 3b37bc7e-020e-45ad-8d86-027d106b90d5
Patch pre-check report

Job ID:  3b37bc7e-020e-45ad-8d86-027d106b90d5
Description:  Patch pre-checks for [OS, GI, ORACHKSERVER, SERVER] to 19.25.0.0
Status:  SUCCESS
Created:  February 3, 2025 6:19:48 AM CET
Result:  All pre-checks succeeded
```

### 8. Apply the Server Update
```
/opt/oracle/dcs/bin/odacli update-server -v 19.25.0.0.0
```
Example:
```
[root@servername ~]# /opt/oracle/dcs/bin/odacli update-server -v 19.25.0.0.0 
{ 
  "jobId" : "cc007ed1-b046-409f-8f3c-3bbeda9fa52e", 
  "status" : "Created", 
  "message" : "Success of server update will trigger reboot of the node after 4-5 minutes. Please wait until the node reboots.", 
  "reports" : [ ], 
  "createTimestamp" : "February 03, 2025 06:44:53 CET", 
  "resourceList" : [ ], 
  "description" : "Server Patching to 19.25.0.0.0", 
  "updatedTime" : "February 03, 2025 06:44:53 CET", 
  "jobType" : null, 
  "cpsMetadata" : null 
}
```

### 9. Check Job Status
```
/opt/oracle/dcs/bin/odacli describe-job -i cc007ed1-b046-409f-8f3c-3bbeda9fa52e
```
Example:
```
[root@servername ~]# /opt/oracle/dcs/bin/odacli describe-job -i cc007ed1-b046-409f-8f3c-3bbeda9fa52e
Job details

ID:  cc007ed1-b046-409f-8f3c-3bbeda9fa52e
Description:  Server Patching to 19.25.0.0.0
Status:  Success
Created:  February 03, 2025 06:44:53 CET
Message:  
```

### 10. Database Patching Pre-checks
```
/opt/oracle/dcs/bin/odacli create-prepatchreport --dbhome --dbhomeid b4550202-0bb2-4fee-96a4-b4373b0e24cf -v 19.25.0.0.0
```
Example:
```
[root@servername ~]# /opt/oracle/dcs/bin/odacli create-prepatchreport --dbhome --dbhomeid b4550202-0bb2-4fee-96a4-b4373b0e24cf -v 19.25.0.0.0
Job details

ID:  0bbff6ce-f331-4822-b7be-6246d2b05622
Description:  Patch pre-checks for [DB, ORACHKDB] to 19.25.0.0: DbHome is OraDB19000_home1
Status:  Created
Created:  February 03, 2025 08:03:11 CET
Message:  Use 'odacli describe-prepatchreport -i 0bbff6ce-f331-4822-b7be-6246d2b05622' to check details of results
```

### 11. Check Pre-patch Report
```
odacli describe-prepatchreport -i 0bbff6ce-f331-4822-b7be-6246d2b05622
```
Example:
```
[root@servername ~]# odacli describe-prepatchreport -i 0bbff6ce-f331-4822-b7be-6246d2b05622
Patch pre-check report

Job ID:  0bbff6ce-f331-4822-b7be-6246d2b05622
Description:  Patch pre-checks for [DB, ORACHKDB] to 19.25.0.0: DbHome is OraDB19000_home1
Status:  FAILED
Created:  February 3, 2025 8:03:11 AM CET
Result:  One or more pre-checks failed for [ORACHK]
```

### 12. Update DBHOME
```
/opt/oracle/dcs/bin/odacli update-dbhome --id b4550202-0bb2-4fee-96a4-b4373b0e24cf -v 19.25.0.0.0 -f
```
Example:
```
[root@servername ~]# /opt/oracle/dcs/bin/odacli update-dbhome --id b4550202-0bb2-4fee-96a4-b4373b0e24cf -v 19.25.0.0.0 -f 
{ 
  "jobId" : "4990aec2-c601-4721-af2b-7d007122e2fa", 
  "status" : "Created", 
  "message" : "", 
  "reports" : [ ], 
  "createTimestamp" : "February 03, 2025 13:23:17 CET", 
  "resourceList" : [ ], 
  "description" : "DB Home Patching to 19.25.0.0.0: Home ID is b4550202-0bb2-4fee-96a4-b4373b0e24cf", 
  "updatedTime" : "February 03, 2025 13:23:17 CET", 
  "jobType" : null, 
  "cpsMetadata" : null 
}
```

### 13. Check Job Status
```
odacli describe-job -i 4990aec2-c601-4721-af2b-7d007122e2fa
```
Example:
```
[root@servername ~]# odacli describe-job -i 4990aec2-c601-4721-af2b-7d007122e2fa
Job details

ID:  4990aec2-c601-4721-af2b-7d007122e2fa
Description:  DB Home Patching to 19.25.0.0.0: Home ID is b4550202-0bb2-4fee-96a4-b4373b0e24cf
Status:  Success
Created:  February 03, 2025 13:23:17 CET
Message:
Task Name                                Node Name                 Start Time                               End Time                                 Status          
---------------------------------------- ------------------------- ---------------------------------------- ---------------------------------------- ----------------
Creating wallet for DB Client            servername             February 03, 2025 13:24:16 CET           February 03, 2025 13:24:17 CET           Success         
Patch databases by RHP - [dbsys]         servername             February 03, 2025 13:24:17 CET           February 03, 2025 13:36:24 CET           Success         
Updating database metadata               servername             February 03, 2025 13:36:25 CET           February 03, 2025 13:36:25 CET           Success         
Set log_archive_dest for Database        servername             February 03, 2025 13:36:25 CET           February 03, 2025 13:36:29 CET           Success         
Generating and saving BOM                servername             February 03, 2025 13:36:31 CET           February 03, 2025 13:37:14 CET           Success         
Generating and saving BOM                servername             February 03, 2025 13:36:31 CET           February 03, 2025 13:37:16 CET           Success         
TDE parameter update                     servername             February 03, 2025 13:37:50 CET           February 03, 2025 13:37:50 CET           Success       
```
