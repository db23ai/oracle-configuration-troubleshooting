Patching Oracle Database Appliance DB Systems Using the Command-Line

# Oracle Database clone files are available in the repository

1. odacli list-availablepatches

Example :

[root@servername~]#  odacli list-availablepatches
-------------------- ------------------------- ------------------------- ------------------------------
ODA Release Version  Supported DB Versions     Available DB Versions     Supported Platforms           
-------------------- ------------------------- ------------------------- ------------------------------
19.26.0.0.0          23.7.0.25.01              Clone not available       DB System                     
                     21.8.0.0.221018           Clone not available       DB System                     
                     19.26.0.0.250121          19.26.0.0.250121          Bare Metal, DB System   


# Connect to the DB system, Update DCS admin

2.  /opt/oracle/dcs/bin/odacli update-dcsadmin -v 19.26.0.0.0
 
 Example :
 
[root@servername ~]# /opt/oracle/dcs/bin/odacli update-dcsadmin -v 19.26.0.0.0
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

# Check Job Status

[root@scaoda819c1n1 ~]# odacli list-jobs | grep -i 9bef3e54-34e3-4641-bcd8-183a9b184f8d 
9bef3e54-34e3-4641-bcd8-183a9b184f8d     DcsAdmin patching                                                           2025-02-03 05:40:39 CET             Success 

# Update the DCS components

3. /opt/oracle/dcs/bin/odacli update-dcscomponents -v 19.26.0.0.0

Example:

[root@servername ~]#  /opt/oracle/dcs/bin/odacli update-dcscomponents -v 19.26.0.0.0
{
  "jobId" : "1c6408df-71a3-4ff1-a5b5-4bf731196480",
  "status" : "Success",
  "message" : "Update-dcscomponents is successful on all the node(s): DCS-Agent shutdown is successful. MySQL upgrade is successful.  Metadata schema update is done. Modified metadata.dcsagent RPM upgrade is successful. dcscli RPM upgrade is successful. dcscontroller RPM upgrade is successful.  Successfully reset the Keystore password. HAMI RPM is already updated.  Removed old Libs Successfully ran setupAgentAuth.sh ",
  "reports" : null,
  "createTimestamp" : "February 03, 2025 05:47:36 AM CET",
  "description" : "Update-dcscomponents job completed and is not part of Agent job list",
  "updatedTime" : "February 03, 2025 05:54:44 AM CET",
  "jobType" : null
}

# Update the DCS agent

4. /opt/oracle/dcs/bin/odacli update-dcsagent -v 19.26.0.0.0

Example:

[root@servername ~]# /opt/oracle/dcs/bin/odacli update-dcsagent -v 19.26.0.0.0
{
  "jobId" : "b1c84c7a-1853-49ef-8732-1a7bc0d982f2",
  "status" : "Created",
  "message" : "",
  "reports" : [ ],
  "createTimestamp" : "February 03, 2025 06:04:44 AM CET",
  "resourceList" : [ ],
  "description" : "DcsAgent patching to 19.26.0.0.0",
  "updatedTime" : "February 03, 2025 06:04:44 AM CET",
  "jobType" : null,
  "cpsMetadata" : null
}

# Check Job Status

[root@servername ~]# odacli list-jobs

b1c84c7a-1853-49ef-8732-1a7bc0d982f2     DcsAgent patching to 19.26.0.0.0                                            2025-02-03 06:04:44 CET             Success         

#  Patching Pre-checks

 /opt/oracle/dcs/bin/odacli create-prepatchreport -s -v 19.26.0.0.0

 Example:

 [root@servername ~]# odacli describe-prepatchreport -i 3b37bc7e-020e-45ad-8d86-027d106b90d5

Patch pre-check report                                           
------------------------------------------------------------------------
                 Job ID:  3b37bc7e-020e-45ad-8d86-027d106b90d5
            Description:  Patch pre-checks for [OS, GI, ORACHKSERVER, SERVER] to 19.26.0.0
                 Status:  SUCCESS
                Created:  February 3, 2025 6:19:48 AM CET
                 Result:  All pre-checks succeeded

Node Name       
---------------
scaoda819c1n1 

Pre-Check                      Status   Comments                              
------------------------------ -------- -------------------------------------- 
__OS__ 
Validate supported versions     Success   Validated minimum supported versions. 
Validate patching tag           Success   Validated patching tag: 19.26.0.0.0.  
Is patch location available     Success   Patch location is available.          
Verify OS patch                 Success   Verified OS patch                     
Validate command execution      Success   Validated command execution           

__GI__ 
Validate GI metadata            Success   Successfully validated GI metadata    
Validate supported GI versions  Success   Successfully validated minimum version
Validate available space        Success   Validated free space under /u01       
Is clusterware running          Success   Clusterware is running                
Validate patching tag           Success   Validated patching tag: 19.26.0.0.0.  
Is system provisioned           Success   Verified system is provisioned        
Validate BM versions            Success   Validated BM server components        
                                          versions                              
Validate kernel log level       Success   Successfully validated the OS log     
                                          level                                 
Validate minimum agent version  Success   GI patching enabled in current        
                                          DCSAGENT version                      
Validate Central Inventory      Success   oraInventory validation passed        
Validate patching locks         Success   Validated patching locks              
Validate clones location exist  Success   Validated clones location             
Evaluate GI patching            Success   Successfully validated GI patching    
Validate command execution      Success   Validated command execution           

__ORACHK__ 
Running orachk                  Success   Successfully ran Orachk               
Validate command execution      Success   Validated command execution           

__SERVER__ 
Validate local patching         Success   Successfully validated server local   
                                          patching                              
Validate all KVM ACFS           Success   All KVM ACFS resources are running    
resources are running                                                           
Validate DB System VM states    Success   All DB System VMs states are expected 
Enable support for Multi-DB     Success   No need to convert the DB System      
Validate command execution      Success   Validated command execution           

Node Name       
---------------
scaoda819c1n2 

Pre-Check                      Status   Comments                              
------------------------------ -------- -------------------------------------- 
__OS__ 
Validate supported versions     Success   Validated minimum supported versions. 
Validate patching tag           Success   Validated patching tag: 19.26.0.0.0.  
Is patch location available     Success   Patch location is available.          
Verify OS patch                 Success   Verified OS patch                     
Validate command execution      Success   Validated command execution           

__GI__ 
Validate GI metadata            Success   Successfully validated GI metadata    
Validate supported GI versions  Success   Successfully validated minimum version
Validate available space        Success   Validated free space under /u01       
Is clusterware running          Success   Clusterware is running                
Validate patching tag           Success   Validated patching tag: 19.26.0.0.0.  
Is system provisioned           Success   Verified system is provisioned        
Validate BM versions            Success   Validated BM server components        
                                          versions                              
Validate kernel log level       Success   Successfully validated the OS log     
                                          level                                 
Validate minimum agent version  Success   GI patching enabled in current        
                                          DCSAGENT version                      
Validate Central Inventory      Success   oraInventory validation passed        
Validate patching locks         Success   Validated patching locks              
Validate clones location exist  Success   Validated clones location             
Evaluate GI patching            Success   Successfully validated GI patching    
Validate command execution      Success   Validated command execution           

__ORACHK__ 
Running orachk                  Success   Successfully ran Orachk               
Validate command execution      Success   Validated command execution           

__SERVER__ 
Validate local patching         Success   Successfully validated server local   
                                          patching                              
Validate all KVM ACFS           Success   All KVM ACFS resources are running    
resources are running                                                           
Validate DB System VM states    Success   All DB System VMs states are expected 
Enable support for Multi-DB     Success   No need to convert the DB System      
Validate command execution      Success   Validated command execution 

# Check Job Status

[root@scaoda819c1n1 ~]# odacli list-jobs | grep -i 3b37bc7e-020e-45ad-8d86-027d106b90d5
3b37bc7e-020e-45ad-8d86-027d106b90d5     Patch pre-checks for [OS, GI, ORACHKSERVER, SERVER] to 19.26.0.0            2025-02-03 06:19:48 CET             Success  

# Apply the server update

/opt/oracle/dcs/bin/odacli update-server -v 19.26.0.0.0

Example:

[root@servername ~]# /opt/oracle/dcs/bin/odacli update-server -v 19.26.0.0.0
{
  "jobId" : "cc007ed1-b046-409f-8f3c-3bbeda9fa52e",
  "status" : "Created",
  "message" : "Success of server update will trigger reboot of the node after 4-5 minutes. Please wait until the node reboots.",
  "reports" : [ ],
  "createTimestamp" : "February 03, 2025 06:44:53 CET",
  "resourceList" : [ ],
  "description" : "Server Patching to 19.26.0.0.0",
  "updatedTime" : "February 03, 2025 06:44:53 CET",
  "jobType" : null,
  "cpsMetadata" : null
}

# Verify server update is successful

/opt/oracle/dcs/bin/odacli describe-job -i cc007ed1-b046-409f-8f3c-3bbeda9fa52e

Example:

[root@servername ~]# /opt/oracle/dcs/bin/odacli describe-job -i cc007ed1-b046-409f-8f3c-3bbeda9fa52e

Job details                                                      
----------------------------------------------------------------
                     ID:  cc007ed1-b046-409f-8f3c-3bbeda9fa52e
            Description:  Server Patching to 19.26.0.0.0
                 Status:  Success
                Created:  February 03, 2025 06:44:53 CET
                Message:  

Task Name                                Node Name                 Start Time                               End Time                                 Status          
---------------------------------------- ------------------------- ---------------------------------------- ---------------------------------------- ----------------
Validating GI user metadata              scaoda819c1n1             February 03, 2025 06:45:38 CET           February 03, 2025 06:45:39 CET           Success         
Validating GI user metadata              scaoda819c1n2             February 03, 2025 06:45:38 CET           February 03, 2025 06:45:39 CET           Success         
Validate DCS Admin mTLS setup            scaoda819c1n1             February 03, 2025 06:45:39 CET           February 03, 2025 06:45:39 CET           Success         
Validate DCS Admin mTLS setup            scaoda819c1n2             February 03, 2025 06:45:39 CET           February 03, 2025 06:45:40 CET           Success         
Deactivate Unit[dnf-makecache.timer]     scaoda819c1n1             February 03, 2025 06:45:40 CET           February 03, 2025 06:45:42 CET           Success         
Deactivate Unit[dnf-makecache.timer]     scaoda819c1n2             February 03, 2025 06:45:40 CET           February 03, 2025 06:45:42 CET           Success         
Modify DBVM udev rules                   scaoda819c1n1             February 03, 2025 06:45:44 CET           February 03, 2025 06:46:04 CET           Success         
Modify DBVM udev rules                   scaoda819c1n2             February 03, 2025 06:45:44 CET           February 03, 2025 06:46:04 CET           Success         
Creating repositories using yum          scaoda819c1n1             February 03, 2025 06:46:05 CET           February 03, 2025 06:46:12 CET           Success         
Creating repositories using yum          scaoda819c1n2             February 03, 2025 06:46:12 CET           February 03, 2025 06:46:20 CET           Success         
Updating YumPluginVersionLock rpm        scaoda819c1n1             February 03, 2025 06:46:20 CET           February 03, 2025 06:46:20 CET           Success         
Updating YumPluginVersionLock rpm        scaoda819c1n2             February 03, 2025 06:46:20 CET           February 03, 2025 06:46:20 CET           Success         
Applying OS Patches                      scaoda819c1n1             February 03, 2025 06:46:20 CET           February 03, 2025 06:53:15 CET           Success         
Applying OS Patches                      scaoda819c1n2             February 03, 2025 06:46:20 CET           February 03, 2025 06:53:10 CET           Success         
Creating repositories using yum          scaoda819c1n1             February 03, 2025 06:53:16 CET           February 03, 2025 06:53:17 CET           Success         
Creating repositories using yum          scaoda819c1n2             February 03, 2025 06:53:17 CET           February 03, 2025 06:53:18 CET           Success         
Applying HMP Patches                     scaoda819c1n2             February 03, 2025 06:53:18 CET           February 03, 2025 06:53:23 CET           Success         
Applying HMP Patches                     scaoda819c1n1             February 03, 2025 06:53:18 CET           February 03, 2025 06:53:23 CET           Success         
Patch location validation                scaoda819c1n1             February 03, 2025 06:53:25 CET           February 03, 2025 06:53:26 CET           Success         
Patch location validation                scaoda819c1n2             February 03, 2025 06:53:25 CET           February 03, 2025 06:53:26 CET           Success         
Oda-hw-mgmt upgrade                      scaoda819c1n1             February 03, 2025 06:53:27 CET           February 03, 2025 06:54:00 CET           Success         
Oda-hw-mgmt upgrade                      scaoda819c1n2             February 03, 2025 06:54:00 CET           February 03, 2025 06:54:43 CET           Success         
Starting the clusterware                 scaoda819c1n2             February 03, 2025 06:57:05 CET           February 03, 2025 06:58:18 CET           Success         
Registering image                        scaoda819c1n2             February 03, 2025 06:58:24 CET           February 03, 2025 06:58:25 CET           Success         
Registering working copy                 scaoda819c1n1             February 03, 2025 06:58:25 CET           February 03, 2025 06:58:25 CET           Success         
Registering image                        scaoda819c1n2             February 03, 2025 06:58:25 CET           February 03, 2025 06:58:25 CET           Success         
Creating GI home directories             scaoda819c1n2             February 03, 2025 06:58:26 CET           February 03, 2025 06:58:26 CET           Success         
Extract GI clone                         scaoda819c1n1             February 03, 2025 06:58:26 CET           February 03, 2025 06:58:26 CET           Success         
Extract GI clone                         scaoda819c1n2             February 03, 2025 06:58:27 CET           February 03, 2025 06:58:27 CET           Success         
Provisioning Software Only GI with RHP   scaoda819c1n1             February 03, 2025 06:58:28 CET           February 03, 2025 06:58:28 CET           Success         
Patch GI with RHP                        scaoda819c1n1             February 03, 2025 06:58:28 CET           February 03, 2025 07:10:23 CET           Success         
Set CRS ping target                      scaoda819c1n1             February 03, 2025 07:10:23 CET           February 03, 2025 07:10:24 CET           Success         
Updating .bashrc                         scaoda819c1n2             February 03, 2025 07:10:25 CET           February 03, 2025 07:10:26 CET           Success         
Server patching                          scaoda819c1n2             February 03, 2025 07:10:28 CET           February 03, 2025 07:10:28 CET           Success         
Updating GIHome version                  scaoda819c1n2             February 03, 2025 07:10:29 CET           February 03, 2025 07:10:40 CET           Success         
Updating GIHome version                  scaoda819c1n1             February 03, 2025 07:10:29 CET           February 03, 2025 07:10:37 CET           Success         
Updating All DBHome version              scaoda819c1n2             February 03, 2025 07:10:41 CET           February 03, 2025 07:10:48 CET           Success         
Updating All DBHome version              scaoda819c1n1             February 03, 2025 07:10:41 CET           February 03, 2025 07:10:49 CET           Success         
Starting the clusterware                 scaoda819c1n2             February 03, 2025 07:10:53 CET           February 03, 2025 07:10:53 CET           Success         
Patch DB System on BM                    scaoda819c1n1             February 03, 2025 07:10:54 CET           February 03, 2025 07:11:00 CET           Success         
Cleanup JRE Home                         scaoda819c1n1             February 03, 2025 07:11:02 CET           February 03, 2025 07:11:02 CET           Success         
Cleanup JRE Home                         scaoda819c1n2             February 03, 2025 07:11:02 CET           February 03, 2025 07:11:03 CET           Success         
Update System version                    scaoda819c1n1             February 03, 2025 07:11:17 CET           February 03, 2025 07:11:17 CET           Success         
Update System version                    scaoda819c1n2             February 03, 2025 07:11:17 CET           February 03, 2025 07:11:17 CET           Success         
Generating and saving BOM                scaoda819c1n1             February 03, 2025 07:11:18 CET           February 03, 2025 07:11:55 CET           Success         
Generating and saving BOM                scaoda819c1n2             February 03, 2025 07:11:18 CET           February 03, 2025 07:11:51 CET           Success         
PreRebootNode Actions                    scaoda819c1n1             February 03, 2025 07:11:55 CET           February 03, 2025 07:12:10 CET           Success         
PreRebootNode Actions                    scaoda819c1n2             February 03, 2025 07:12:10 CET           February 03, 2025 07:12:20 CET           Success         
Reboot Node                              scaoda819c1n1             February 03, 2025 07:12:20 CET           February 03, 2025 07:12:20 CET           Success         
Reboot Node                              scaoda819c1n2             February 03, 2025 07:12:21 CET           February 03, 2025 07:12:21 CET           Success         

# Check Job Status

[root@scaoda819c1n1 ~]# odacli list-jobs | grep -i cc007ed1-b046-409f-8f3c-3bbeda9fa52e
cc007ed1-b046-409f-8f3c-3bbeda9fa52e     Server Patching to 19.26.0.0.0                                              2025-02-03 06:44:53 CET             Success 


# Database Patching Pre-checks

[root@servername ~]# /opt/oracle/dcs/bin/odacli create-prepatchreport --dbhome --dbhomeid b4550202-0bb2-4fee-96a4-b4373b0e24cf -v 19.26.0.0.0

Job details                                                      
----------------------------------------------------------------
                     ID:  0bbff6ce-f331-4822-b7be-6246d2b05622
            Description:  Patch pre-checks for [DB, ORACHKDB] to 19.26.0.0: DbHome is OraDB19000_home1
                 Status:  Created
                Created:  February 03, 2025 08:03:11 CET
                Message:  Use 'odacli describe-prepatchreport -i 0bbff6ce-f331-4822-b7be-6246d2b05622' to check details of results

                
# 
[root@servername ~]# /opt/oracle/dcs/bin/odacli update-dbhome --id b4550202-0bb2-4fee-96a4-b4373b0e24cf -v 19.26.0.0.0 -f
{
  "jobId" : "4990aec2-c601-4721-af2b-7d007122e2fa",
  "status" : "Created",
  "message" : "",
  "reports" : [ ],
  "createTimestamp" : "February 03, 2025 13:23:17 CET",
  "resourceList" : [ ],
  "description" : "DB Home Patching to 19.26.0.0.0: Home ID is b4550202-0bb2-4fee-96a4-b4373b0e24cf",
  "updatedTime" : "February 03, 2025 13:23:17 CET",
  "jobType" : null,
  "cpsMetadata" : null
