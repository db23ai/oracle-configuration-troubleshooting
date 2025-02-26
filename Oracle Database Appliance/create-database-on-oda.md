# Creating a Database in Oracle Database Appliance

## 1. Create Database with ASM Storage

### Step 1: Create database using ASM storage

```bash
odacli create-database -n orcl -s odb1 -p pdb1 -r asm -c -y RAC -u orcl_src -t
```

### Step 2: Check database status

```bash
odacli list-jobs | grep -i 23b281d3-5688-44e2-8628-6f8404347c2a
```

### Step 3: Describe database & verify parameter values

```bash
odacli describe-database -n orcl
```

### Example:

```bash
[root@servername ~]# odacli create-database -n orcl -s odb1 -p pdb1 -r asm -c -y RAC -u orcl_src -t
Enter SYS, SYSTEM and PDB Admin user password: 
Retype SYS, SYSTEM and PDB Admin user password: 
Enter TDE wallet password: 
Retype TDE wallet password: 

Job details                                                      
----------------------------------------------------------------
                     ID:  23b281d3-5688-44e2-8628-6f8404347c2a
            Description:  Database service creation with DB name: orcl
                 Status:  Created
                Created:  February 19, 2025 06:12:39 CET
                Message:  

Task Name                                Start Time                               End Time                                 Status          
---------------------------------------- ---------------------------------------- ---------------------------------------- ----------------
```

### Example:

```bash
[root@servername ~]# odacli list-jobs | grep -i 23b281d3-5688-44e2-8628-6f8404347c2a
23b281d3-5688-44e2-8628-6f8404347c2a     Database service creation with DB name: orcl  2025-02-19 06:12:39 CET   Success  
```

### Example:

```bash
[root@servername ~]# odacli describe-database -n orcl
Database details                                                  
---------------------------------------------------------------- 
                     ID: 166c3d31-2606-4194-9f53-468affc641dd
            Description: orcl
                DB Name: orcl
             DB Version: 19.25.0.0.241021
                DB Type: RAC
                DB Role: PRIMARY
    DB Target Node Name: 
             DB Edition: EE
                   DBID: 1554687582
 Instance Only Database: false
                    CDB: true
               PDB Name: pdb1
    PDB Admin User Name: pdbadmin
      High Availability: false
                  Class: OLTP
                  Shape: odb1
                Storage: ASM
          DB Redundancy: MIRROR
           CharacterSet: AL32UTF8
  National CharacterSet: AL16UTF16
               Language: AMERICAN
              Territory: AMERICA
                Home ID: e92a72b6-f8b5-4d89-b939-5e2150b4db45
        Console Enabled: false
  TDE Wallet Management: ODA
            TDE Enabled: true
     Level 0 Backup Day: sunday
     AutoBackup Enabled: false
                Created: February 19, 2025 6:12:39 AM CET
         DB Domain Name: us.oracle.com
    Associated Networks: Public-network 
          CPU Pool Name: 
```

## 2. Create Database with ACFS Storage

### Step 1: Create database using ACFS storage

```bash
odacli create-database -n ora19c -s odb1 -p pdb1 -r acfs -c -y RAC -u ora19c_src -t
```

### Step 2: Check database status

```bash
odacli list-jobs | grep -i 48d07e45-0c38-4ba4-8164-5572d5145f90
```

### Step 3: Describe database & verify parameter values

```bash
odacli describe-database -n ora19c
```

### Example:

```bash
[root@servername ~]# odacli create-database -n ora19c -s odb1 -p pdb1 -r acfs -c -y RAC -u ora19c_src -t
Enter SYS, SYSTEM and PDB Admin user password: 
Retype SYS, SYSTEM and PDB Admin user password: 
Enter TDE wallet password: 
Retype TDE wallet password: 

Job details                                                      
----------------------------------------------------------------
                     ID:  48d07e45-0c38-4ba4-8164-5572d5145f90
            Description:  Database service creation with DB name: ora19c
                 Status:  Created
                Created:  February 19, 2025 06:14:26 CET
                Message:  

Task Name                                Start Time                               End Time                                 Status          
---------------------------------------- ---------------------------------------- ---------------------------------------- ----------------
```

### Example:

```bash
[root@servername ~]# odacli list-jobs | grep -i 48d07e45-0c38-4ba4-8164-5572d5145f90
48d07e45-0c38-4ba4-8164-5572d5145f90     Database service creation with DB name: ora19c    2025-02-19 06:14:26 CET             Success 
```

### Example:

```bash
[root@servername ~]# odacli describe-database -n ora19c
Database details                                                  
---------------------------------------------------------------- 
                     ID: 40dd4ea6-fa01-4bc3-b1df-2abd3f4dcce9
            Description: ora19c
                DB Name: ora19c
             DB Version: 19.25.0.0.241021
                DB Type: RAC
                DB Role: PRIMARY
    DB Target Node Name: 
             DB Edition: EE
                   DBID: 2788959726
 Instance Only Database: false
                    CDB: true
               PDB Name: pdb1
    PDB Admin User Name: pdbadmin
      High Availability: false
                  Class: OLTP
                  Shape: odb1
                Storage: ACFS
          DB Redundancy: MIRROR
           CharacterSet: AL32UTF8
  National CharacterSet: AL16UTF16
               Language: AMERICAN
              Territory: AMERICA
                Home ID: 0efc6dfe-6ffc-435f-bfb8-75acdc739b0b
        Console Enabled: false
  TDE Wallet Management: ODA
            TDE Enabled: true
     Level 0 Backup Day: sunday
     AutoBackup Enabled: false
                Created: February 19, 2025 6:14:26 AM CET
         DB Domain Name: us.oracle.com
    Associated Networks: Public-network 
          CPU Pool Name: 
```
