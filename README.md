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


