# How to Convert Standby to Standalone Database

-- Login as SYS user

sqlplus / as sysdba

-- Check current role of database

SQL> select database_role from v$database;

-- Conver standby to standalong

SQL> alter database recover managed standby database finish;

SQL> alter database commit to switchover to primary with session shutdown;

-- Shutdown Database

SQL> shutdown immediate;

-- Start Database

SQL> startup

-- Check current role of database

SQL> select database_role from v$database;


Output of above command :

[oracle@server ~]$ sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Thu Aug 24 09:09:46 2023
Version 19.18.0.0.0

Copyright (c) 1982, 2022, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.18.0.0.0

SQL> select database_role from v$database;

DATABASE_ROLE

----------------
PHYSICAL STANDBY

SQL> alter database recover managed standby database finish;

Database altered.

SQL> alter database commit to switchover to primary with session shutdown;

Database altered.

SQL> shutdown immediate;

ORA-01109: database not open

Database dismounted.

ORACLE instance shut down.


SQL> startup

ORACLE instance started.

Total System Global Area 4288512536 bytes

Fixed Size                  9171480 bytes

Variable Size             939524096 bytes

Database Buffers         3305111552 bytes

Redo Buffers               34705408 bytes

Database mounted.

Database opened.

SQL> select database_role from v$database;

DATABASE_ROLE

----------------
PRIMARY

SQL>



