# How to Convert Standby to Standalone Databases

## 1. Check current role of database

Login as SYS user:

```sql
sqlplus / as sysdba
select database_role from v$database;
```

Example:

```shell
[oracle@server ~]$ sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Thu Aug 24 09:09:46 2023
Version 19.18.0.0.0
Copyright (c) 1982, 2022, Oracle. All rights reserved.

Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.18.0.0.0

SQL> select database_role from v$database;

DATABASE_ROLE
--------------
PHYSICAL STANDBY
```

## 2. Convert standby to standalone

```sql
alter database recover managed standby database finish;
```

Example:

```sql
SQL> alter database recover managed standby database finish;

Database altered.
```

```sql
alter database commit to switchover to primary with session shutdown;
```

Example:

```sql
SQL> alter database commit to switchover to primary with session shutdown;

Database altered.
```

## 3. Shutdown Database

```sql
shutdown immediate;
```

Example:

```sql
SQL> shutdown immediate;

Database dismounted.
ORACLE instance shut down.
```

## 4. Start Database

```sql
startup;
```

Example:

```sql
SQL> startup;

ORACLE instance started.

Total System Global Area 4288512536 bytes
Fixed Size                  9171480 bytes
Variable Size             939524096 bytes
Database Buffers         3305111552 bytes
Redo Buffers               34705408 bytes
Database mounted.
Database opened.
```

## 5. Check current role of database

```sql
select database_role from v$database;
```

Example:

```sql
SQL> select database_role from v$database;

DATABASE_ROLE
--------------
PRIMARY
```
