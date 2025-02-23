# How to Convert Standby to Standalone Databases

# 1. Check current role of database

-- Login as SYS user

sqlplus / as sysdba

select database_role from v$database;

Example:

[oracle@server ~]$ sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Thu Aug 24 09:09:46 2023
Version 19.18.0.0.0
Copyright (c) 1982, 2022, Oracle.  All rights reserved.
Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.18.0.0.0

SQL> select database_role from v$database;

DATABASE_ROLE

PHYSICAL STANDBY

# 2 Conver standby to standalone

alter database recover managed standby database finish;

Example:

SQL> alter database recover managed standby database finish;

Database altered.

alter database commit to switchover to primary with session shutdown;

Example:

SQL> alter database commit to switchover to primary with session shutdown;

Database altered.

# 3. Shutdown Database

shutdown immediate;

Example:

SQL> shutdown immediate;

Database dismounted.

ORACLE instance shut down.

# 4. Start Database

startup

Example:

SQL> startup

ORACLE instance started.

Total System Global Area 4288512536 bytes

Fixed Size                  9171480 bytes

Variable Size             939524096 bytes

Database Buffers         3305111552 bytes

Redo Buffers               34705408 bytes

Database mounted.

Database opened.

# 5. Check current role of database

select database_role from v$database;

Example:

SQL> select database_role from v$database;

DATABASE_ROLE                                                                                                          
                                                                                                                       
PRIMARY

















