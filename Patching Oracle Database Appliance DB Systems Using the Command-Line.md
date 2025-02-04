Patching Oracle Database Appliance DB Systems Using the Command-Line

1. Oracle Database clone files are available in the repository

odacli list-availablepatches

Example :

[root@servername~]#  odacli list-availablepatches
-------------------- ------------------------- ------------------------- ------------------------------
ODA Release Version  Supported DB Versions     Available DB Versions     Supported Platforms           
-------------------- ------------------------- ------------------------- ------------------------------
19.25.0.0.0          23.7.0.25.01              Clone not available       DB System                     
                     21.8.0.0.221018           Clone not available       DB System                     
                     19.25.0.0.250121          19.25.0.0.250121          Bare Metal, DB System   


2. Connect to the DB system, Update DCS admin

/opt/oracle/dcs/bin/odacli update-dcsadmin -v 19.25.0.0.0
 
 Example :
 
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

-- Check Job Status

[root@servername ~]# odacli describe-job -i 9bef3e54-34e3-4641-bcd8-183a9b184f8d 

Job details                                                      
----------------------------------------------------------------
                     ID:  9bef3e54-34e3-4641-bcd8-183a9b184f8d
            Description:  DcsAdmin patching
                 Status:  Success
                Created:  February 03, 2025 05:40:39 CET
                Message:  

Task Name                                Node Name                 Start Time                               End Time                                 Status          
---------------------------------------- ------------------------- ---------------------------------------- ---------------------------------------- ----------------
Patch location validation                servername             February 03, 2025 05:40:42 CET           February 03, 2025 05:40:42 CET           Success         
Patch location validation                servername             February 03, 2025 05:40:42 CET           February 03, 2025 05:40:43 CET           Success         
Dcs-admin upgrade                        servername             February 03, 2025 05:40:44 CET           February 03, 2025 05:40:55 CET           Success         
Dcs-admin upgrade                        servername             February 03, 2025 05:40:55 CET           February 03, 2025 05:41:06 CET           Success                                                               

3. Update the DCS components

/opt/oracle/dcs/bin/odacli update-dcscomponents -v 19.25.0.0.0

Example:

[root@servername ~]#  /opt/oracle/dcs/bin/odacli update-dcscomponents -v 19.25.0.0.0
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

4. Update the DCS agent

/opt/oracle/dcs/bin/odacli update-dcsagent -v 19.25.0.0.0

Example:

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

-- Check Job Status

[root@servername ~]# odacli describe-job -i b1c84c7a-1853-49ef-8732-1a7bc0d982f2

Job details                                                      
----------------------------------------------------------------
                     ID:  b1c84c7a-1853-49ef-8732-1a7bc0d982f2
            Description:  DcsAgent patching to 19.26.0.0.0
                 Status:  Success
                Created:  February 03, 2025 06:04:44 CET
                Message:  

Task Name                                Node Name                 Start Time                               End Time                                 Status          
---------------------------------------- ------------------------- ---------------------------------------- ---------------------------------------- ----------------
Dcs-agent upgrade  to version            servername             February 03, 2025 06:04:46 CET           February 03, 2025 06:07:39 CET           Success         
19.26.0.0.0                                                                                                                                                          
Dcs-agent upgrade  to version            servername             February 03, 2025 06:07:39 CET           February 03, 2025 06:10:38 CET           Success         
19.26.0.0.0       

5. Patching Pre-checks

 /opt/oracle/dcs/bin/odacli create-prepatchreport -s -v 19.25.0.0.0

 Example:

 [root@servername ~]# odacli describe-prepatchreport -i 3b37bc7e-020e-45ad-8d86-027d106b90d5

Patch pre-check report                                           
------------------------------------------------------------------------
                 Job ID:  3b37bc7e-020e-45ad-8d86-027d106b90d5
            Description:  Patch pre-checks for [OS, GI, ORACHKSERVER, SERVER] to 19.25.0.0
                 Status:  SUCCESS
                Created:  February 3, 2025 6:19:48 AM CET
                 Result:  All pre-checks succeeded

Node Name       
---------------
servername-node0

Pre-Check                      Status   Comments                              
------------------------------ -------- -------------------------------------- 
__OS__ 
Validate supported versions     Success   Validated minimum supported versions. 
Validate patching tag           Success   Validated patching tag: 19.25.0.0.0.  
Is patch location available     Success   Patch location is available.          
Verify OS patch                 Success   Verified OS patch                     
Validate command execution      Success   Validated command execution           

__GI__ 
Validate GI metadata            Success   Successfully validated GI metadata    
Validate supported GI versions  Success   Successfully validated minimum version
Validate available space        Success   Validated free space under /u01       
Is clusterware running          Success   Clusterware is running                
Validate patching tag           Success   Validated patching tag: 19.25.0.0.0.  
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
servername-node1

Pre-Check                      Status   Comments                              
------------------------------ -------- -------------------------------------- 
__OS__ 
Validate supported versions     Success   Validated minimum supported versions. 
Validate patching tag           Success   Validated patching tag: 19.25.0.0.0.  
Is patch location available     Success   Patch location is available.          
Verify OS patch                 Success   Verified OS patch                     
Validate command execution      Success   Validated command execution           

__GI__ 
Validate GI metadata            Success   Successfully validated GI metadata    
Validate supported GI versions  Success   Successfully validated minimum version
Validate available space        Success   Validated free space under /u01       
Is clusterware running          Success   Clusterware is running                
Validate patching tag           Success   Validated patching tag: 19.25.0.0.0.  
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

-- Check Job Status

[root@servername ~]# odacli describe-job -i 3b37bc7e-020e-45ad-8d86-027d106b90d5

Job details                                                      
----------------------------------------------------------------
                     ID:  3b37bc7e-020e-45ad-8d86-027d106b90d5
            Description:  Patch pre-checks for [OS, GI, ORACHKSERVER, SERVER] to 19.26.0.0
                 Status:  Success
                Created:  February 03, 2025 06:19:48 CET
                Message:  Use 'odacli describe-prepatchreport -i <ID>' to check prepatch results

Task Name                                Node Name                 Start Time                               End Time                                 Status          
---------------------------------------- ------------------------- ---------------------------------------- ---------------------------------------- ----------------
Setting up SSH equivalence               servername             February 03, 2025 06:20:12 CET           February 03, 2025 06:20:16 CET           Success         
Setting up SSH equivalence               servername             February 03, 2025 06:20:16 CET           February 03, 2025 06:20:20 CET           Success         
Run patching pre-checks                  servername             February 03, 2025 06:20:20 CET           February 03, 2025 06:39:08 CET           Success         
Registering image                        servername             February 03, 2025 06:23:24 CET           February 03, 2025 06:23:25 CET           Success         
Registering working copy                 servername             February 03, 2025 06:23:25 CET           February 03, 2025 06:23:26 CET           Success         
Registering image                        servername             February 03, 2025 06:23:27 CET           February 03, 2025 06:23:27 CET           Success         
Creating GI home directories             servername             February 03, 2025 06:23:27 CET           February 03, 2025 06:23:28 CET           Success         
Extract GI clone                         servername             February 03, 2025 06:23:28 CET           February 03, 2025 06:25:18 CET           Success         
Extract GI clone                         servername             February 03, 2025 06:25:18 CET           February 03, 2025 06:27:08 CET           Success         
Provisioning Software Only GI with RHP   servername             February 03, 2025 06:27:09 CET           February 03, 2025 06:28:37 CET           Success         
Patch GI with RHP                        servername             February 03, 2025 06:28:37 CET           February 03, 2025 06:29:45 CET           Success         

6. Apply the server update

/opt/oracle/dcs/bin/odacli update-server -v 19.25.0.0.0

Example:

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

-- Check Job Status

/opt/oracle/dcs/bin/odacli describe-job -i cc007ed1-b046-409f-8f3c-3bbeda9fa52e

Example:

[root@servername ~]# /opt/oracle/dcs/bin/odacli describe-job -i cc007ed1-b046-409f-8f3c-3bbeda9fa52e

Job details                                                      
----------------------------------------------------------------
                     ID:  cc007ed1-b046-409f-8f3c-3bbeda9fa52e
            Description:  Server Patching to 19.25.0.0.0
                 Status:  Success
                Created:  February 03, 2025 06:44:53 CET
                Message:  

Task Name                                Node Name                 Start Time                               End Time                                 Status          
---------------------------------------- ------------------------- ---------------------------------------- ---------------------------------------- ----------------
Validating GI user metadata              servername             February 03, 2025 06:45:38 CET           February 03, 2025 06:45:39 CET           Success         
Validating GI user metadata              servername             February 03, 2025 06:45:38 CET           February 03, 2025 06:45:39 CET           Success         
Validate DCS Admin mTLS setup            servername             February 03, 2025 06:45:39 CET           February 03, 2025 06:45:39 CET           Success         
Validate DCS Admin mTLS setup            servername             February 03, 2025 06:45:39 CET           February 03, 2025 06:45:40 CET           Success         
Deactivate Unit[dnf-makecache.timer]     servername             February 03, 2025 06:45:40 CET           February 03, 2025 06:45:42 CET           Success         
Deactivate Unit[dnf-makecache.timer]     servername             February 03, 2025 06:45:40 CET           February 03, 2025 06:45:42 CET           Success         
Modify DBVM udev rules                   servername             February 03, 2025 06:45:44 CET           February 03, 2025 06:46:04 CET           Success         
Modify DBVM udev rules                   servername             February 03, 2025 06:45:44 CET           February 03, 2025 06:46:04 CET           Success         
Creating repositories using yum          servername             February 03, 2025 06:46:05 CET           February 03, 2025 06:46:12 CET           Success         
Creating repositories using yum          servername             February 03, 2025 06:46:12 CET           February 03, 2025 06:46:20 CET           Success         
Updating YumPluginVersionLock rpm        servername             February 03, 2025 06:46:20 CET           February 03, 2025 06:46:20 CET           Success         
Updating YumPluginVersionLock rpm        servername             February 03, 2025 06:46:20 CET           February 03, 2025 06:46:20 CET           Success         
Applying OS Patches                      servername             February 03, 2025 06:46:20 CET           February 03, 2025 06:53:15 CET           Success         
Applying OS Patches                      servername             February 03, 2025 06:46:20 CET           February 03, 2025 06:53:10 CET           Success         
Creating repositories using yum          servername             February 03, 2025 06:53:16 CET           February 03, 2025 06:53:17 CET           Success         
Creating repositories using yum          servername             February 03, 2025 06:53:17 CET           February 03, 2025 06:53:18 CET           Success         
Applying HMP Patches                     servername             February 03, 2025 06:53:18 CET           February 03, 2025 06:53:23 CET           Success         
Applying HMP Patches                     servername             February 03, 2025 06:53:18 CET           February 03, 2025 06:53:23 CET           Success         
Patch location validation                servername             February 03, 2025 06:53:25 CET           February 03, 2025 06:53:26 CET           Success         
Patch location validation                servername             February 03, 2025 06:53:25 CET           February 03, 2025 06:53:26 CET           Success         
Oda-hw-mgmt upgrade                      servername             February 03, 2025 06:53:27 CET           February 03, 2025 06:54:00 CET           Success         
Oda-hw-mgmt upgrade                      servername             February 03, 2025 06:54:00 CET           February 03, 2025 06:54:43 CET           Success         
Starting the clusterware                 servername             February 03, 2025 06:57:05 CET           February 03, 2025 06:58:18 CET           Success         
Registering image                        servername             February 03, 2025 06:58:24 CET           February 03, 2025 06:58:25 CET           Success         
Registering working copy                 servername             February 03, 2025 06:58:25 CET           February 03, 2025 06:58:25 CET           Success         
Registering image                        servername             February 03, 2025 06:58:25 CET           February 03, 2025 06:58:25 CET           Success         
Creating GI home directories             servername             February 03, 2025 06:58:26 CET           February 03, 2025 06:58:26 CET           Success         
Extract GI clone                         servername             February 03, 2025 06:58:26 CET           February 03, 2025 06:58:26 CET           Success         
Extract GI clone                         servername             February 03, 2025 06:58:27 CET           February 03, 2025 06:58:27 CET           Success         
Provisioning Software Only GI with RHP   servername             February 03, 2025 06:58:28 CET           February 03, 2025 06:58:28 CET           Success         
Patch GI with RHP                        servername             February 03, 2025 06:58:28 CET           February 03, 2025 07:10:23 CET           Success         
Set CRS ping target                      servername             February 03, 2025 07:10:23 CET           February 03, 2025 07:10:24 CET           Success         
Updating .bashrc                         servername             February 03, 2025 07:10:25 CET           February 03, 2025 07:10:26 CET           Success         
Server patching                          servername             February 03, 2025 07:10:28 CET           February 03, 2025 07:10:28 CET           Success         
Updating GIHome version                  servername             February 03, 2025 07:10:29 CET           February 03, 2025 07:10:40 CET           Success         
Updating GIHome version                  servername             February 03, 2025 07:10:29 CET           February 03, 2025 07:10:37 CET           Success         
Updating All DBHome version              servername             February 03, 2025 07:10:41 CET           February 03, 2025 07:10:48 CET           Success         
Updating All DBHome version              servername             February 03, 2025 07:10:41 CET           February 03, 2025 07:10:49 CET           Success         
Starting the clusterware                 servername             February 03, 2025 07:10:53 CET           February 03, 2025 07:10:53 CET           Success         
Patch DB System on BM                    servername             February 03, 2025 07:10:54 CET           February 03, 2025 07:11:00 CET           Success         
Cleanup JRE Home                         servername             February 03, 2025 07:11:02 CET           February 03, 2025 07:11:02 CET           Success         
Cleanup JRE Home                         servername             February 03, 2025 07:11:02 CET           February 03, 2025 07:11:03 CET           Success         
Update System version                    servername             February 03, 2025 07:11:17 CET           February 03, 2025 07:11:17 CET           Success         
Update System version                    servername             February 03, 2025 07:11:17 CET           February 03, 2025 07:11:17 CET           Success         
Generating and saving BOM                servername             February 03, 2025 07:11:18 CET           February 03, 2025 07:11:55 CET           Success         
Generating and saving BOM                servername             February 03, 2025 07:11:18 CET           February 03, 2025 07:11:51 CET           Success         
PreRebootNode Actions                    servername             February 03, 2025 07:11:55 CET           February 03, 2025 07:12:10 CET           Success         
PreRebootNode Actions                    servername             February 03, 2025 07:12:10 CET           February 03, 2025 07:12:20 CET           Success         
Reboot Node                              servername             February 03, 2025 07:12:20 CET           February 03, 2025 07:12:20 CET           Success         
Reboot Node                              servername             February 03, 2025 07:12:21 CET           February 03, 2025 07:12:21 CET           Success         

-- Check Job Status

[root@servername ~]# odacli describe-job -i cc007ed1-b046-409f-8f3c-3bbeda9fa52e

Job details                                                      
----------------------------------------------------------------
                     ID:  cc007ed1-b046-409f-8f3c-3bbeda9fa52e
            Description:  Server Patching to 19.26.0.0.0
                 Status:  Success
                Created:  February 03, 2025 06:44:53 CET
                Message:  

Task Name                                Node Name                 Start Time                               End Time                                 Status          
---------------------------------------- ------------------------- ---------------------------------------- ---------------------------------------- ----------------
Validating GI user metadata              servername             February 03, 2025 06:45:38 CET           February 03, 2025 06:45:39 CET           Success         
Validating GI user metadata              servername             February 03, 2025 06:45:38 CET           February 03, 2025 06:45:39 CET           Success         
Validate DCS Admin mTLS setup            servername             February 03, 2025 06:45:39 CET           February 03, 2025 06:45:39 CET           Success         
Validate DCS Admin mTLS setup            servername             February 03, 2025 06:45:39 CET           February 03, 2025 06:45:40 CET           Success         
Deactivate Unit[dnf-makecache.timer]     servername             February 03, 2025 06:45:40 CET           February 03, 2025 06:45:42 CET           Success         
Deactivate Unit[dnf-makecache.timer]     servername             February 03, 2025 06:45:40 CET           February 03, 2025 06:45:42 CET           Success         
Modify DBVM udev rules                   servername             February 03, 2025 06:45:44 CET           February 03, 2025 06:46:04 CET           Success         
Modify DBVM udev rules                   servername             February 03, 2025 06:45:44 CET           February 03, 2025 06:46:04 CET           Success         
Creating repositories using yum          servername             February 03, 2025 06:46:05 CET           February 03, 2025 06:46:12 CET           Success         
Creating repositories using yum          servername             February 03, 2025 06:46:12 CET           February 03, 2025 06:46:20 CET           Success         
Updating YumPluginVersionLock rpm        servername             February 03, 2025 06:46:20 CET           February 03, 2025 06:46:20 CET           Success         
Updating YumPluginVersionLock rpm        servername             February 03, 2025 06:46:20 CET           February 03, 2025 06:46:20 CET           Success         
Applying OS Patches                      servername             February 03, 2025 06:46:20 CET           February 03, 2025 06:53:15 CET           Success         
Applying OS Patches                      servername             February 03, 2025 06:46:20 CET           February 03, 2025 06:53:10 CET           Success         
Creating repositories using yum          servername             February 03, 2025 06:53:16 CET           February 03, 2025 06:53:17 CET           Success         
Creating repositories using yum          servername             February 03, 2025 06:53:17 CET           February 03, 2025 06:53:18 CET           Success         
Applying HMP Patches                     servername             February 03, 2025 06:53:18 CET           February 03, 2025 06:53:23 CET           Success         
Applying HMP Patches                     servername             February 03, 2025 06:53:18 CET           February 03, 2025 06:53:23 CET           Success         
Patch location validation                servername             February 03, 2025 06:53:25 CET           February 03, 2025 06:53:26 CET           Success         
Patch location validation                servername             February 03, 2025 06:53:25 CET           February 03, 2025 06:53:26 CET           Success         
Oda-hw-mgmt upgrade                      servername             February 03, 2025 06:53:27 CET           February 03, 2025 06:54:00 CET           Success         
Oda-hw-mgmt upgrade                      servername             February 03, 2025 06:54:00 CET           February 03, 2025 06:54:43 CET           Success         
Starting the clusterware                 servername             February 03, 2025 06:57:05 CET           February 03, 2025 06:58:18 CET           Success         
Registering image                        servername             February 03, 2025 06:58:24 CET           February 03, 2025 06:58:25 CET           Success         
Registering working copy                 servername             February 03, 2025 06:58:25 CET           February 03, 2025 06:58:25 CET           Success         
Registering image                        servername             February 03, 2025 06:58:25 CET           February 03, 2025 06:58:25 CET           Success         
Creating GI home directories             servername             February 03, 2025 06:58:26 CET           February 03, 2025 06:58:26 CET           Success         
Extract GI clone                         servername             February 03, 2025 06:58:26 CET           February 03, 2025 06:58:26 CET           Success         
Extract GI clone                         servername             February 03, 2025 06:58:27 CET           February 03, 2025 06:58:27 CET           Success         
Provisioning Software Only GI with RHP   servername             February 03, 2025 06:58:28 CET           February 03, 2025 06:58:28 CET           Success         
Patch GI with RHP                        servername             February 03, 2025 06:58:28 CET           February 03, 2025 07:10:23 CET           Success         
Set CRS ping target                      servername             February 03, 2025 07:10:23 CET           February 03, 2025 07:10:24 CET           Success         
Updating .bashrc                         servername             February 03, 2025 07:10:25 CET           February 03, 2025 07:10:26 CET           Success         
Server patching                          servername             February 03, 2025 07:10:28 CET           February 03, 2025 07:10:28 CET           Success         
Updating GIHome version                  servername             February 03, 2025 07:10:29 CET           February 03, 2025 07:10:40 CET           Success         
Updating GIHome version                  servername             February 03, 2025 07:10:29 CET           February 03, 2025 07:10:37 CET           Success         
Updating All DBHome version              servername             February 03, 2025 07:10:41 CET           February 03, 2025 07:10:48 CET           Success         
Updating All DBHome version              servername             February 03, 2025 07:10:41 CET           February 03, 2025 07:10:49 CET           Success         
Starting the clusterware                 servername             February 03, 2025 07:10:53 CET           February 03, 2025 07:10:53 CET           Success         
Patch DB System on BM                    servername             February 03, 2025 07:10:54 CET           February 03, 2025 07:11:00 CET           Success         
Cleanup JRE Home                         servername             February 03, 2025 07:11:02 CET           February 03, 2025 07:11:02 CET           Success         
Cleanup JRE Home                         servername             February 03, 2025 07:11:02 CET           February 03, 2025 07:11:03 CET           Success         
Update System version                    servername             February 03, 2025 07:11:17 CET           February 03, 2025 07:11:17 CET           Success         
Update System version                    servername             February 03, 2025 07:11:17 CET           February 03, 2025 07:11:17 CET           Success         
Generating and saving BOM                servername             February 03, 2025 07:11:18 CET           February 03, 2025 07:11:55 CET           Success         
Generating and saving BOM                servername             February 03, 2025 07:11:18 CET           February 03, 2025 07:11:51 CET           Success         
PreRebootNode Actions                    servername             February 03, 2025 07:11:55 CET           February 03, 2025 07:12:10 CET           Success         
PreRebootNode Actions                    servername             February 03, 2025 07:12:10 CET           February 03, 2025 07:12:20 CET           Success         
Reboot Node                              servername             February 03, 2025 07:12:20 CET           February 03, 2025 07:12:20 CET           Success         
Reboot Node                              servername             February 03, 2025 07:12:21 CET           February 03, 2025 07:12:21 CET           Success         
                                 

9. Database Patching Pre-checks

[root@servername ~]# /opt/oracle/dcs/bin/odacli create-prepatchreport --dbhome --dbhomeid b4550202-0bb2-4fee-96a4-b4373b0e24cf -v 19.25.0.0.0

Job details                                                      
----------------------------------------------------------------
                     ID:  0bbff6ce-f331-4822-b7be-6246d2b05622
            Description:  Patch pre-checks for [DB, ORACHKDB] to 19.25.0.0: DbHome is OraDB19000_home1
                 Status:  Created
                Created:  February 03, 2025 08:03:11 CET
                Message:  Use 'odacli describe-prepatchreport -i 0bbff6ce-f331-4822-b7be-6246d2b05622' to check details of results

                
10. Update DBHOME
    
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

[root@servername ~]# odacli describe-job -i 4990aec2-c601-4721-af2b-7d007122e2fa

Job details                                                      
----------------------------------------------------------------
                     ID:  4990aec2-c601-4721-af2b-7d007122e2fa
            Description:  DB Home Patching to 19.26.0.0.0: Home ID is b4550202-0bb2-4fee-96a4-b4373b0e24cf
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
