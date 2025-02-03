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

[root@servername ~]# odacli list-jobs

ID                                       Description                                                                 Created                             Status          
---------------------------------------- --------------------------------------------------------------------------- ----------------------------------- ----------------        
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

Example :

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

