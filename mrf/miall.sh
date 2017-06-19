#!/bin/bash

#***************************************************************************************************
#          Variables definded
#***************************************************************************************************

comp=$1
bulnum=$2
workspace=`pwd`
rpm_dir="$workspace/rpm_dir"


#*******************************************************************************************************************
#          create_Html()
#          Argument:
#                      @previous_build_notes_Array = Previous build Notes.
#
#          Returns: This is main subroutines call other subroutines and create Final Build Notes in HTML format.
#*******************************************************************************************************************

help (){
        echo "Choose the component"
	echo "mi_bulkconfig"
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

mi_bulkconfig (){
mi_bulkconfigurationtool_branch=bulkconfigurationtool_mrf$bulnum
if [ -d $mi_bulkconfigurationtool_branch ]; then
        echo "$workspace/$mi_bulkconfigurationtool_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_bulkconfigurationtool_branch
        svn update
else
        echo "Going for svn checkout of $mi_bulkconfigurationtool_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/BulkConfigurationTool/branches/$mi_bulkconfigurationtool_branch
        cd $mi_bulkconfigurationtool_branch
fi
if [ $?=0 ]; then
        chmod +x MainMakefile; ./MainMakefile
        mkdir $rpm_dir/$mi_bulkconfigurationtool_branch/
        cd $rpm_dir/$mi_bulkconfigurationtool_branch/
        cp -rf $workspace/$mi_bulkconfigurationtool_branch/*.rpm .
else
        echo "Error: SVN Checkout failed $?"
fi

}


mi_checkhostconfig (){
mi_checkhostsconfigfile_branch=checkhostsconfigfile_mrf$bulnum
if [ -d $mi_checkhostsconfigfile_branch ]; then
        echo "$workspace/$mi_checkhostsconfigfile_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_checkhostsconfigfile_branch
        svn update
else
        echo "Going for svn checkout of $mi_checkhostsconfigfile_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/CheckHostsConfigFile/branches/$mi_checkhostsconfigfile_branch
        cd $mi_checkhostsconfigfile_branch
fi
if [ $?=0 ]; then
        cd make; ./make-rpm.sh
        mkdir $rpm_dir/$mi_checkhostsconfigfile_branch/
        cp -rf $workspace/$mi_checkhostsconfigfile_branch/make/*.rpm $rpm_dir/$mi_checkhostsconfigfile_branch/
else
        echo "Error: SVN Checkout failed $?"
fi

}

mi_cloud (){
mi_cloud_branch=cloud_mrf$bulnum
if [ -d $mi_cloud_branch ]; then
        echo "$workspace/$mi_cloud_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_cloud_branch
        svn update
else
        echo "Going for svn checkout of $mi_cloud_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/Cloud/branches/$mi_cloud_branch
        cd $mi_cloud_branch
fi
if [ $?=0 ]; then
        cd  CloudAddon/mrfExchange/; ./make-rpm.sh
        mkdir $rpm_dir/$mi_cloud_branch/
        cp -rf ./*.rpm  $rpm_dir/$mi_cloud_branch/
        cd ../Identity/; ./make-rpm.sh
        cp -rf ./*.rpm  $rpm_dir/$mi_cloud_branch/
        cd ../Monitoring/; ./make-rpm.sh
        cp -rf ./*.rpm  $rpm_dir/$mi_cloud_branch/
        cd ../../CloudPrepare/Cleaner; ./make-rpm.sh
        cp -rf ./*.rpm  $rpm_dir/$mi_cloud_branch/
        cd ../../CloudAddon/rhcs2node/rpm/rhcs2node/; chmod -R 777 .; ./makerpm $bulnum
        cp -rf ./*.rpm  $rpm_dir/$mi_cloud_branch/
else
        echo "Error: SVN Checkout failed $?"
fi
}

mi_drbd (){
mi_drbd_branch=drbd_mrf$bulnum
if [ -d $mi_drbd_branch ]; then
        echo "$workspace/$mi_drbd_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_drbd_branch
        svn update
else
        echo "Going for svn checkout of $mi_drbd_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/drbd/branches/$mi_drbd_branch
        cd $mi_drbd_branch
fi
if [ $?=0 ]; then
        tar -chzf mrfdrbd-1.2.0.tar.gz mrfdrbd-1.2.0
        mkdir -p /usr/src/redhat/SOURCES/
        cp -rf mrfdrbd-1.2.0.tar.gz /usr/src/redhat/SOURCES/
        cp -rf /build/RPM/usr/src/redhat/RPMS/noarch/mrfdrbd-1.2.0-01.noarch.rpm /usr/src/redhat/RPMS/noarch/
else
        echo "Error: SVN Checkout failed $?"
fi
}

mi_dri_mrf (){
mi_dri_mrf_branch=dri_mrf$bulnum
if [ -d $mi_dri_mrf_branch ]; then
        echo "$workspace/$mi_dri_mrf_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_dri_mrf_branch
        svn update
else
        echo "Going for svn checkout of $mi_dri_mrf_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/DRI/branches/$mi_dri_mrf_branch
        cd $mi_dri_mrf_branch
fi
if [ $?=0 ]; then
        ./make-rpm.sh
        mkdir $rpm_dir/$mi_dri_mrf_branch/
        cp -rf ./*.rpm $rpm_dir/$mi_dri_mrf_branch/
else
        echo "Error: SVN Checkout failed $?"
fi

}

mi_initmrf (){
mi_initmrf_branch=initmrf_mrf$bulnum
if [ -d $mi_initmrf_branch ]; then
        echo "$workspace/$mi_initmrf_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_initmrf_branch
        svn update
else
        echo "Going for svn checkout of $mi_initmrf_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/Init_MRF/branches/$mi_initmrf_branch
        cd $mi_initmrf_branch
fi
if [ $?=0 ]; then
        cd make; ./make-rpm.sh
        mkdir $rpm_dir/$mi_initmrf_branch
        cp -rf ./*.rpm $rpm_dir/$mi_initmrf_branch/
else
        echo "Error: SVN Checkout failed $?"
fi
}

mi_initsu (){
mi_cloud_branch=cloud_mrf$bulnum
if [ -d $mi_cloud_branch ]; then
        echo "$workspace/$mi_cloud_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_cloud_branch
        svn update
else
        echo "Going for svn checkout of $mi_cloud_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/Cloud/branches/$mi_cloud_branch
        cd $mi_cloud_branch
fi
if [ $?=0 ]; then
        cd CloudAddon/OpenStack/Deployment/su-mrf/initsu
        ./makerpm
        mkdir $rpm_dir/initsu_mrf11.5.0.3/
        cp -rf ./*.rpm $rpm_dir/initsu_mrf11.5.0.3/
else
        echo "Error: SVN Checkout failed $?"
fi
}

mi_healthcheck (){
mi_healthcheck_branch=healthcheck_mrf$bulnum
if [ -d $mi_healthcheck_branch ]; then
        echo "$workspace/$mi_healthcheck_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_healthcheck_branch
        svn update
else
        echo "Going for svn checkout of $mi_healthcheck_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/healthcheck/branches/$mi_healthcheck_branch
        cd $mi_healthcheck_branch
fi
if [ $?=0 ]; then

        ./make-rpm.sh
        mkdir $rpm_dir/$mi_healthcheck_branch
        cp -rf ./*.rpm $rpm_dir/$mi_healthcheck_branch
else
        echo "Error: SVN Checkout failed $?"
fi
}


mi_healthcheck_plugin_validatenf (){
mi_sytemdelivery_branch=sytemdelivery_mrf$bulnum
if [ -d $mi_sytemdelivery_branch ]; then
        echo "$workspace/$mi_sytemdelivery_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_sytemdelivery_branch
        svn update
else
        echo "Going for svn checkout of $mi_sytemdelivery_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/sytem-delivery/branches/$mi_sytemdelivery_branch
        cd $mi_sytemdelivery_branch
fi
if [ $?=0 ]; then
        cd miToolbox/healthcheck/validateNF/make
        ./make-rpm.sh
        mkdir $rpm_dir/healthcheck_plugin_validatenf$bulnum
        cp -rf ./*.rpm $rpm_dir/healthcheck_plugin_validatenf$bulnum
else
        echo "Error: SVN Checkout failed $?"
fi
}

mi_healthcheck_plugin_vsippcall (){
mi_sytemdelivery_branch=sytemdelivery_mrf$bulnum
if [ -d $mi_sytemdelivery_branch ]; then
        echo "$workspace/$mi_sytemdelivery_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_sytemdelivery_branch
        svn update
else
        echo "Going for svn checkout of $mi_sytemdelivery_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/sytem-delivery/branches/$mi_sytemdelivery_branch
        cd $mi_sytemdelivery_branch
fi
if [ $?=0 ]; then
        cd miToolbox/healthcheck/vSippCall/make
        ./make-rpm.sh
        mkdir $rpm_dir/healthcheck_plugin_vsippcall$bulnum
        cp -rf ./*.rpm $rpm_dir/healthcheck_plugin_vsippcall$bulnum
else
        echo "Error: SVN Checkout failed $?"
fi
}

mi_httpconf (){
mi_httpconf_branch=httpconf_mrf$bulnum
if [ -d $mi_httpconf_branch ]; then
        echo "$workspace/$mi_httpconf_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_httpconf_branch
        svn update
else
        echo "Going for svn checkout of $mi_httpconf_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/http-conf/branches/$mi_httpconf_branch
        cd $mi_httpconf_branch
fi
if [ $?=0 ]; then
        ./make-rpm.sh
        mkdir $rpm_dir/$mi_httpconf_branch
        cp -rf ./*.rpm $rpm_dir/$mi_httpconf_branch
else
        echo "Error: SVN Checkout failed $?"
fi

}


mi_checktools (){
mi_sytemdelivery_branch=sytemdelivery_mrf$bulnum
if [ -d $mi_sytemdelivery_branch ]; then
        echo "$workspace/$mi_sytemdelivery_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_sytemdelivery_branch
        svn update
else
        echo "Going for svn checkout of $mi_sytemdelivery_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/sytem-delivery/branches/$mi_sytemdelivery_branch
        cd $mi_sytemdelivery_branch
fi
if [ $?=0 ]; then
        cd miToolbox/packages/miCheckTools; ./make-rpm.sh
        mkdir $rpm_dir/checktools_mrf$bulnum
        cp -rf ./*.rpm  $rpm_dir/checktools_mrf$bulnum
else
        echo "Error: SVN Checkout failed $?"
fi
}

mi_datatools (){
mi_sytemdelivery_branch=sytemdelivery_mrf$bulnum
if [ -d $mi_sytemdelivery_branch ]; then
        echo "$workspace/$mi_sytemdelivery_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_sytemdelivery_branch
        svn update
else
        echo "Going for svn checkout of $mi_sytemdelivery_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/sytem-delivery/branches/$mi_sytemdelivery_branch
        cd $mi_sytemdelivery_branch
fi
if [ $?=0 ]; then
        cd miToolbox/packages/miDataTools; ./make-rpm.sh
        mkdir $rpm_dir/datatools_mrf$bulnum
        cp -rf ./*.rpm $rpm_dir/datatools_mrf$bulnum
else
        echo "Error: SVN Checkout failed $?"
fi
}

mi_install (){
mi_sytemdelivery_branch=sytemdelivery_mrf$bulnum
if [ -d $mi_sytemdelivery_branch ]; then
        echo "$workspace/$mi_sytemdelivery_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_sytemdelivery_branch
        svn update
else
        echo "Going for svn checkout of $mi_sytemdelivery_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/sytem-delivery/branches/$mi_sytemdelivery_branch
        cd $mi_sytemdelivery_branch
fi
if [ $?=0 ]; then
        cd miToolbox/packages/miInstallTools; ./make-rpm.sh
        mkdir $rpm_dir/install_mrf$bulnum
        cp -rf ./*.rpm $rpm_dir/install_mrf$bulnum
else
        echo "Error: SVN Checkout failed $?"
fi
}

mi_mrfmaa (){
mi_mrfmaa_branch=mrfmaa_mrf$bulnum
if [ -d $mi_mrfmaa_branch ]; then
        echo "$workspace/$mi_mrfmaa_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_mrfmaa_branch
        svn update
else
        echo "Going for svn checkout of $mi_mrfmaa_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/mrfmaa/branches/$mi_mrfmaa_branch
        cd $mi_mrfmaa_branch
fi
if [ $?=0 ]; then
        ./makerpm
        mkdir $rpm_dir/$mi_mrfmaa_branch
        cp -rf ./*.rpm $rpm_dir/$mi_mrfmaa_branch
else
        echo "Error: SVN Checkout failed $?"
fi
}

mi_python_patch (){
weboam_branch=weboam_mrf$bulnum
if [ -d $weboam_branch ]; then
        echo "$workspace/$weboam_branch is already exist, Going for svn update.."
        sleep 5
        cd $weboam_branch
        svn update
else
        echo "Going for svn checkout of $weboam_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/weboam/branches/$weboam_branch
        cd $weboam_branch
fi
if [ $?=0 ]; then
        cd python_patch; ./make-rpm.sh
        mkdir $rpm_dir/python_patch_mrf$bulnum
        cp -rf ./*.rpm $rpm_dir/python_patch_mrf$bulnum
else
        echo "Error: SVN Checkout failed $?"
fi
}

mi_mrfsqlbk (){
mi_mrfsqlbk_branch=mrfsqlbk_mrf$bulnum
if [ -d $mi_mrfsqlbk_branch ]; then
        echo "$workspace/$mi_mrfsqlbk_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_mrfsqlbk_branch
        svn update
else
        echo "Going for svn checkout of $mi_mrfsqlbk_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/mrfsqlbk/branches/$mi_mrfsqlbk_branch
        cd $mi_mrfsqlbk_branch
fi
if [ $?=0 ]; then
        cp -rf /home/mrfnk/tars/11.5/mrfsqlbk_MRF_11.5.0.0.tgz /build/RPM/usr/src/redhat/SOURCES/
        ./makerpm
        mkdir $rpm_dir/$mi_mrfsqlbk_branch/
        cp -rf ./*.rpm $rpm_dir/$mi_mrfsqlbk_branch/
else
        echo "Error: SVN Checkout failed $?"
fi
}

mi_smartdhook (){
mi_smartdhook_branch=smartdhook_mrf$bulnum
if [ -d $mi_smartdhook_branch ]; then
        echo "$workspace/$mi_smartdhook_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_smartdhook_branch
        svn update
else
        echo "Going for svn checkout of $mi_smartdhook_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/smartdHook/branches/$mi_smartdhook_branch
        cd $mi_smartdhook_branch
fi
if [ $?=0 ]; then
        ./makerpm
        mkdir $rpm_dir/$mi_smartdhook_branch
        cp -rf ./*.rpm $rpm_dir/$mi_smartdhook_branch
else
        echo "Error: SVN Checkout failed $?"
fi
}

mi_sutool (){
mi_cloud_branch=cloud_mrf$bulnum
if [ -d $mi_cloud_branch ]; then
        echo "$workspace/$mi_cloud_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_cloud_branch
        svn update
else
        echo "Going for svn checkout of $mi_cloud_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/Cloud/branches/$mi_cloud_branch
        cd $mi_cloud_branch
fi
if [ $?=0 ]; then
        cd CloudAddon/OpenStack/Deployment/su-mrf/sutool
        ./makerpm
        mkdir $rpm_dir/sutool_mrf$bulnum
        cp -rf ./*.rpm $rpm_dir/sutool_mrf$bulnum
else
        echo "Error: SVN Checkout failed $?"
fi
}

mi_systemdelivery (){
mi_sytemdelivery_branch=sytemdelivery_mrf$bulnum
if [ -d $mi_sytemdelivery_branch ]; then
        echo "$workspace/$mi_sytemdelivery_branch is already exist, Going for svn update.."
        sleep 5
        cd $mi_sytemdelivery_branch
        svn update
else
        echo "Going for svn checkout of $mi_sytemdelivery_branch directory.."
        sleep 5
        svn co http://svn.radisys.com/svn/nmrf/sytem-delivery/branches/$mi_sytemdelivery_branch
        cd $mi_sytemdelivery_branch
fi
if [ $?=0 ]; then
        mkdir $rpm_dir/$mi_sytemdelivery_branch/
        cd miToolbox; ./make-rpm.sh
        cp -rf ./*.rpm $rpm_dir/$mi_sytemdelivery_branch/
        cd ../platform-update; ./make-rpm.sh
        cp -rf ./*.rpm $rpm_dir/$mi_sytemdelivery_branch/
        cd ../MRF-Remote-Tools; ./make-rpm.sh
        cp -rf ./*.rpm $rpm_dir/$mi_sytemdelivery_branch/
        cd ../configMergeTool; ./make-rpm.sh
        cp -rf ./*.rpm $rpm_dir/$mi_sytemdelivery_branch/
        cd ../backup-restore; ./make-rpm.sh
        cp -rf ./*.rpm $rpm_dir/$mi_sytemdelivery_branch/
        cd ../hardening; ./make-rpm.sh
        cp -rf ./*.rpm $rpm_dir/$mi_sytemdelivery_branch/
        cd ../monitoring-tools; ./make-rpm.sh
        cp -rf ./*.rpm $rpm_dir/$mi_sytemdelivery_branch/
        cd ../MRF-Remote-Upgrade; ./make-rpm.sh
        cp -rf ./*.rpm $rpm_dir/$mi_sytemdelivery_branch/
        cd ../syslog2amm-catalog; ./make-rpm.sh
        cp -rf ./*.rpm $rpm_dir/$mi_sytemdelivery_branch/
        cd ../hardening-catalogs; ./make-rpm.sh
        cp -rf ./*.rpm $rpm_dir/$mi_sytemdelivery_branch/
        cd ../upgrade-tools; ./make-rpm.sh
        cp -rf ./*.rpm $rpm_dir/$mi_sytemdelivery_branch/
        cd ../mcdp-update; ./make-rpm.sh
        cp -rf ./*.rpm $rpm_dir/$mi_sytemdelivery_branch/
        cd ../mrfDoxygen; ./make-rpm.sh
        cp -rf ./*.rpm $rpm_dir/$mi_sytemdelivery_branch/
else
        echo "Error: SVN Checkout failed $?"
fi
}


# Main Function starts

if [ "$1" == "All" ]; then      #if block starts
        # Calling all the m&i component
        mi_bulkconfig
	mi_checkhostconfig
	mi_cloud
	mi_drbd
	mi_dri_mrf
	mi_initmrf
	mi_initsu
	mi_healthcheck
	mi_healthcheck_plugin_validatenf
	mi_healthcheck_plugin_vsippcall
	mi_httpconf
	mi_checktools
	mi_datatools
	mi_install
	mi_mrfmaa
	mi_python_patch
	mi_mrfsqlbk
	mi_smartdhook
	mi_sutool
	mi_systemdelivery

elif [ "$1" == "mi_bulkconfig" ]; then

        mi_bulkconfig  #Calling a function

elif [ "$1" == "mi_checkhostconfig" ]; then

        mi_checkhostconfig  #Calling a function

elif [ "$1" == "mi_cloud" ]; then

        mi_cloud  #Calling a function

elif [ "$1" == "mi_drbd" ]; then

	mi_drbd		#calling a function

elif [ "$1" == "mi_dri_mrf" ]; then

	mi_dri_mrf	#calling a function

elif [ "$1" == "mi_initmrf" ]; then

        mi_initmrf         #calling a function

elif [ "$1" == "mi_initsu" ]; then

        mi_initsu	#calling a function

elif [ "$1" == "mi_healthcheck" ]; then

        mi_healthcheck       #calling a function

elif [ "$1" == "mi_healthcheck_plugin_validatenf" ]; then

        mi_healthcheck_plugin_validatenf      #calling a function

elif [ "$1" == "mi_healthcheck_plugin_vsippcall" ]; then

        mi_healthcheck_plugin_vsippcall		#calling a function

elif [ "$1" == "mi_httpconf" ]; then

        mi_httpconf         #calling a function

elif [ "$1" == "mi_checktools" ]; then

        mi_checktools         #calling a function

elif [ "$1" == "mi_datatools" ]; then

        mi_datatools         #calling a function

elif [ "$1" == "mi_install" ]; then

        mi_install         #calling a function

elif [ "$1" == "mi_mrfmaa" ]; then

        mi_mrfmaa         #calling a function

elif [ "$1" == "mi_python_patch" ]; then

        mi_python_patch         #calling a function

elif [ "$1" == "mi_mrfsqlbk" ]; then

        mi_mrfsqlbk         #calling a function

elif [ "$1" == "mi_smartdhook" ]; then

        mi_smartdhook         #calling a function

elif [ "$1" == "mi_sutool" ]; then

        mi_sutool         #calling a function

elif [ "$1" == "mi_systemdelivery" ]; then

        mi_systemdelivery         #calling a function

elif [ "$1" == "-h"]; then

	help

else
	echo "Enter correct component"

fi	#end of if

