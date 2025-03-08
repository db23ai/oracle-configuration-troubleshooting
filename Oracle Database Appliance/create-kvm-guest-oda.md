# How to Create KVM Guest on ODA

## 1. Create CPU Pool

```sh
odacli create-cpupool -n kvmcpu -c 10 -vm
```

### Example

```sh
[root@servername ~]# odacli create-cpupool -n kvmcpu -c 10 -vm

Job details                                                      
----------------------------------------------------------------
                     ID:  a6f14053-5403-4bac-a78b-f0aae8c5e28d
            Description:  CPU Pool kvmguest creation
                 Status:  Created
                Created:  February 19, 2025 17:57:45 CET
                Message:  

Task Name                                Start Time                               End Time                                 Status          
---------------------------------------- ---------------------------------------- ---------------------------------------- ----------------
```

## 2. Create VM Storage

```sh
odacli create-vmstorage -n kvmvmstorage -s 400G -dg DATA
```

### Example

```sh
[root@servername ~]# odacli create-vmstorage -n kvmvmstorage -s 400G -dg DATA

Job details                                                      
----------------------------------------------------------------
                     ID:  9af3b798-7ece-4f76-b5a1-93e015aae14d
            Description:  VM storage kvmvmstorage creation
                 Status:  Created
                Created:  February 19, 2025 17:59:08 CET
                Message:  

Task Name                                Start Time                               End Time                                 Status          
---------------------------------------- ---------------------------------------- ---------------------------------------- ----------------
```

## 3. Create Virtual Disk

```sh
odacli create-vdisk -n kvmdisk -vms kvmvmstorage -s 200G -sh
```

### Example

```sh
[root@servername ~]# odacli create-vdisk -n kvmdisk -vms kvmvmstorage -s 200G -sh

Job details                                                      
----------------------------------------------------------------
                     ID:  973a5a51-44b8-4c63-8e9e-6780c79d6115
            Description:  VDisk kvmdisk creation
                 Status:  Created
                Created:  February 19, 2025 17:59:34 CET
                Message:  

Task Name                                Start Time                               End Time                                 Status          
---------------------------------------- ---------------------------------------- ---------------------------------------- ----------------
```

## 4. Check Job Status

```sh
odacli list-jobs
```

### Example

```sh
[root@servername ~]# odacli list-jobs
a6f14053-5403-4bac-a78b-f0aae8c5e28d     CPU Pool kvmtest creation                     2025-02-19 17:57:45 CET             Success         
9af3b798-7ece-4f76-b5a1-93e015aae14d     VM storage kvmvmstore creation                2025-02-19 17:59:08 CET             Success         
973a5a51-44b8-4c63-8e9e-6780c79d6115     VDisk kvmdisk creation                        2025-02-19 17:59:34 CET             Success  
```

## 5. Copy ISO of Oracle Linux 8.7

```sh
scp testuser@100.10.10.10:/scratch/software/oraclelinux8.7/V1032420-01.iso /tmp/V1032420-01.iso
```

## 6. Create KVM

```sh
odacli create-vm -n ocpvm -vc 4 -m 16G -vms kvmvmstorage -vd kvmdisk -s 100G -cp kvmcpu -vn pubnet -src /tmp/V1009690-01.iso --graphics vnc,listen=0.0.0.0
```
