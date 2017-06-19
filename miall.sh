#!/bin/bash

comp=$1
Branch_name=$2

help (){
        echo "Choose the component"
        echo "BulkConfigurationTool"
        echo "mi_checkhostsconfig"
        echo "mi_cloud"
        echo "mi_drbd"
        echo "mi_dri_mrf"
        echo "mi_initmrf"
        echo "mi_initsu"
        echo "mi_healthcheck"
        echo "mi_healthcheck_plugin_validatenf"
        echo "mi_healthcheck_plugin_vsippcall"
        echo "mi_httpconf"
        echo "mi_checktools"
        echo "mi_datatools"
        echo "mi_install"
        echo "mi_mrfmaa"
        echo "mi_python_patch"
        echo "mi_mrfsqlbk"
        echo "mi_smarthook"
        echo "mi_sutool"
        echo "mi_systemdelivery"
}

BulkConfigurationTool (){
cd /home/mrfnk/workspace/test/$1/$2
chmod +x MainMakefile; ./MainMakefile
cp -rf *.rpm ${RPM_DIR}

}

if [ "$1" == "All" ]; then      #if block starts
        # Calling all the m&i component
        BulkConfigurationTool

elif [ "$1" == "BulkConfigurationTool" ]; then

        BulkConfigurationTool  #Calling a function

elif [ "$1" == "-h"]; then

        help

else
        echo "Enter correct component"

fi      #end of if
