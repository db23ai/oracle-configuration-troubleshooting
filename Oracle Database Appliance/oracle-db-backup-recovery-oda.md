# Oracle Database Appliance Backup & Recovery

This guide provides the steps to perform backup and recovery operations on Oracle Database Appliance using the `odacli` command-line tool.

## Steps to Take Backup & Recovery

### 1. Create Backup Configuration

Create a backup configuration with the name `dailybackup` and set it to run every day (`-w 1`).

```bash
odacli create-backupconfig -d Disk -n dailybackup -w 1
```

### 2. Modify Database to Use Backup Configuration

Modify the database `orcl` to use the backup configuration `dailybackup`.

```bash
odacli modify-database -n orcl -bin dailybackup
```

### 3. Create Backup

Create a Level 0 (full) backup for the database `orcl` with the tag `2024JUNE27`.

```bash
odacli create-backup -i 826788cf-16f9-4a2c-97a1-89be9cb07e38 -bt Regular-L0 -t 2024JUNE27
```

### 4. Recover Database

Recover the database `orcl` to the latest backup.

```bash
odacli recover-database -i 826788cf-16f9-4a2c-97a1-89be9cb07e38 -t Latest
```

## Example

Below is an example of the commands as executed on a server.

### List Databases

```bash
[root@servername ~]# odacli list-databases
ID                                     DBName  DB Type    DB Version        CDB    Class  Edition  Shape  Storage  StatusDB       Home ID        
---------------------------------------- ---------- -------- -------------------- ------- -------- -------- -------- -------- --------------------------------------- 
826788cf-16f9-4a2c-97a1-89be9cb07e38   orcl     RAC       19.20.0.0.0      true    OLTP   EE       odb4   ASM      CONFIGURED    8d044fc1-b9b2-4ebe-b6b5-d50217115933
```

### Create Backup Configuration

```bash
[root@test ~]# odacli create-backupconfig -d Disk -n dailybackup -w 1
{
  "jobId" : "d0565230-443a-47f8-9b4a-cb1f3f8e36ab",
  "status" : "Created",
  "message" : "backup config creation",
  "reports" : [ ],
  "createTimestamp" : "June 27, 2024 09:07:08 AM CEST",
  "resourceList" : [ {
    "resourceId" : "4a2e38f6-dade-4c37-90b8-c0a2a7c74140",
    "resourceType" : null,
    "resourceNewType" : "BackupConfig",
    "jobId" : "d0565230-443a-47f8-9b4a-cb1f3f8e36ab",
    "updatedTime" : null
  } ],
  "description" : "Create Backup Config: dailybackup",
  "updatedTime" : "June 27, 2024 09:07:08 AM CEST",
  "jobType" : null
}
```

### Modify Database

```bash
[root@test ~]# odacli modify-database -n orcl -bin dailybackup
{
  "jobId" : "e0a88f43-6d4b-4876-825f-d8f8913204bb",
  "status" : "Created",
  "message" : "Modify database",
  "reports" : [ ],
  "createTimestamp" : "June 27, 2024 09:07:31 AM CEST",
  "resourceList" : [ {
    "resourceId" : "826788cf-16f9-4a2c-97a1-89be9cb07e38",
    "resourceType" : null,
    "resourceNewType" : "Db",
    "jobId" : "e0a88f43-6d4b-4876-825f-d8f8913204bb",
    "updatedTime" : null
  } ],
  "description" : "Modify database: orcl",
  "updatedTime" : "June 27, 2024 09:07:31 AM CEST",
  "jobType" : null
}
```

### Create Backup

```bash
[root@servername ~]# odacli create-backup -i 826788cf-16f9-4a2c-97a1-89be9cb07e38 -bt Regular-L0 -t 2024JUNE27
{
  "jobId" : "4b16173c-2734-406c-8168-4f29b01b318d",
  "status" : "Created",
  "message" : "",
  "reports" : [ ],
  "createTimestamp" : "June 27, 2024 09:10:56 AM CEST",
  "resourceList" : [ ],
  "description" : "Create Regular-L0 Backup[TAG:2024JUNE27][Db:orcl][FRA]",
  "updatedTime" : "June 27, 2024 09:10:56 AM CEST",
  "jobType" : null
}
```

### Recover Database

```bash
[root@servername ~]# odacli recover-database -i 826788cf-16f9-4a2c-97a1-89be9cb07e38 -t Latest
{
  "jobId" : "20c575a8-dfbf-4c56-9b2b-a14271295e3b",
  "status" : "Created",
  "message" : null,
  "reports" : [ ],
  "createTimestamp" : "June 27, 2024 09:15:17 AM CEST",
  "resourceList" : [ ],
  "description" : "Create recovery-latest for DB : orcl",
  "updatedTime" : "June 27, 2024 09:15:17 AM CEST",
  "jobType" : null
}
```

### List Jobs

```bash
[root@servername ~]# odacli list-jobs

d0565230-443a-47f8-9b4a-cb1f3f8e36ab     Create Backup Config: dailybackup                                2024-06-27 09:07:08 CEST           Success
e0a88f43-6d4b-4876-825f-d8f8913204bb     Modify database: orcl                                           2024-06-27 09:07:31 CEST            Success
4b16173c-2734-406c-8168-4f29b01b318d     Create Regular-L0 Backup[TAG:2024JUNE27][Db:orcl][FRA]          2024-06-27 09:10:56 CEST            Success
20c575a8-dfbf-4c56-9b2b-a14271295e3b     Create recovery-latest for DB : orcl                            2024-06-27 09:15:17 CEST            Success
```
