Patching Oracle Database Appliance DB Systems Using the Command-Line

# Oracle Database clone files are available in the repository

odacli list-availablepatches

Example :

[root@servername~]#  odacli list-availablepatches
-------------------- ------------------------- ------------------------- ------------------------------
ODA Release Version  Supported DB Versions     Available DB Versions     Supported Platforms           
-------------------- ------------------------- ------------------------- ------------------------------
19.26.0.0.0          23.7.0.25.01              Clone not available       DB System                     
                     21.8.0.0.221018           Clone not available       DB System                     
                     19.26.0.0.250121          19.26.0.0.250121          Bare Metal, DB System   
