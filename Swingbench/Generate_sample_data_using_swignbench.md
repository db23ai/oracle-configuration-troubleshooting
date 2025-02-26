# Oracle Schema Data Generation

This guide outlines the steps to generate and replicate 2TB of data for an Oracle schema using Swingbench.

## Prerequisites

- Latest version of Swingbench
- Java 17

## Steps

### 1. Download and Install Swingbench and Java 17

- Download the latest Swingbench:

  [Swingbench Latest](https://www.dominicgiles.com/site_downloads/swingbenchlatest.zip)

- Download the latest Java:

  [Swingbench JDK 11](https://www.dominicgiles.com/site_downloads/swingbench04112023_jdk11.zip)

- Extract Swingbench:

  ```shell
  unzip swingbenchlatest.zip -d swingbench
  ```

- Extract and install Java:

  ```shell
  unzip swingbench04112023_jdk11.zip -d jdk11
  cd jdk
  yum install jdk-17.0.12_linux-x64_bin.rpm --nogpgcheck
  ```

### 2. Generate 50GB of Data

This step will create tablespace, schema, and insert the data.

```shell
cd /home/oracle/swingbench/bin
./oewizard -cl -create -cs //hostname or scanname/pdb-servicename -u soe -p password$1 -scale 50 -tc 32 -dba "sys as sysdba" -dbap password$1 -ts soe
```

### 3. Duplicate Existing Schema Data

Replicate the generated 50GB data 39 times to achieve approximately 2TB of data.

```shell
cd /home/oracle/swingbench/bin
./sbutil -u soe -p password$1 -cs //hostname or scan-name/pdb-servicename -soe -parallel 64 -dup 39
```

### 4. Query the Size of the Oracle Schema

```sql
sqlplus / as sysdba
alter session set container=pdb1;
col OWNER for a30
col SCHEMA_SIZE_GB for 999999
select owner, sum(bytes)/1024/1024/1024 schema_size_GB from dba_segments where owner='SOE' group by owner;
```

### Notes

- The schema size may differ due to platform-dependent indexes.
- To run commands in the background, use `nohup`:

  ```shell
  nohup filename.sh &
  ```

For more information, visit [Dominic Giles Downloads](https://www.dominicgiles.com/downloads/).
