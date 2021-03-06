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

#Declaring a function

innkbld01 () {
sshpass -p 'zxcv@1234' ssh root@172.24.100.211 $1
} 

interpreter (){
	echo "Interpreter"
	echo "$bulnum"

	#svn co http://svn.radisys.com/svn/nmrf/mediaserver/branches/mediaserver_mrf$bulnum
}

hbmr-imr (){
	echo "HBMR/IMR"
	echo "$bulnum"
       #svn co http://svn.radisys.com/svn/nmrf/mediaserver/branches/mediaserver_mrf$bulnum

}

mcdp (){
	echo "MCDP"
	echo "$bulnum"
	#svn co http://svn.radisys.com/svn/nmrf/mediaserver/branches/mediaserver_mrf$bulnum
}

weboam (){
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
fi
if [ $?=0 ]; then
	cd $weboam_branch;
	chmod -R 775 patch_mngt
	PWD=`pwd`
	export SOURCEDIR=$PWD/../..
	export WORKDIR=$PWD
	make all; make gtar
	if [ $?=0 ]; then
		echo "Weboam build passed successfully"
		echo "Going to DO ngms defence build.."
		echo ""
		sleep 5
		cd defense; ./make-rpm.sh
		mkdir $rpm_dir/$weboam_branch
		cp -rf *.rpm $rpm_dir/$weboam_branch/
		cp -rf ../patch_mngt/Patchmngt_weboam/*.rpm $rpm_dir/$weboam_branch/
		rpm_name=`ls $rpm_dir/$weboam_branch/`
		echo "Weboam rpm's -->$rpm_dir/$weboam_branch/$rpm_name"
	else
		echo "weboam build failed $?"
	fi
else
	echo "Error: SVN Checkout failed $?"
fi
}

mpm (){
mpm_branch=mpm_mrf$bulnum
if [ -d $mpm_branch ]; then
	echo "$workspace/$mpm_branch is already exist, Going for svn update.."
	sleep 5
	cd $mpm_branch
	svn update
else
	echo "Going for svn checkout of $mpm_branch directory.."
	sleep 5 
	svn co http://svn.radisys.com/svn/nmrf/mpm/branches/$mpm_branch
fi		
if [ $?=0 ]; then
	cd $mpm_branch; cmake .; make
	if [ $?=0 ]; then
		echo "M&I mpm build passed successfully"
		chmod u+x mkrpm; ./mkrpm
		if [ -d $rpm_dir/$mpm_branch ]; then
			cp -rf delivery/*.rpm $rpm_dir/$mpm_branch
			echo ""
			echo "MPM rpm's --> $rpm_dir/$mpm_branch/$rpm_name"
			echo ""
		else
			mkdir -p $rpm_dir/$mpm_branch
			cp -rf delivery/*.rpm $rpm_dir/$mpm_branch
			rpm_name=`ls delivery/*.rpm`
			echo ""
			echo "MPM rpm's --> $rpm_dir/$mpm_branch/$rpm_name"
			echo ""
		fi
	else
		echo "M&I mpm build failed $?"
	fi
else
	echo "Error: SVN Checkout failed $?"
fi
}

vxmlinterpreter (){
vxmlinterpreter_branch=vxmlinterpreter_mrf$bulnum
if [ -d $vxmlinterpreter_branch ]; then
	echo "$workspace/$vxmlinterpreter_branch is already exist, Going for svn update.."
 	sleep 5
   	cd $vxmlinterpreter_branch
	svn update
else
	echo "Going for svn checkout of $vxmlinterpreter_branch directory.."
	sleep 5
        svn co http://svn.radisys.com/svn/nmrf/VxmlInterpreter/branches/$vxmlinterpreter_branch
	cd $vxmlinterpreter_branch
fi
if [ $?=0 ]; then
	JAVA_HOME=/opt/java
	ant -f build.xml
	if [ $?=0 ]; then
		echo "M&I vxmlinterpreter  build passed successfully"
		chmod -R 777 .;
        	chmod 777 mkrpm; innkbld01 $workspace/$vxmlinterpreter_branch/mkrpm
		mkdir -p $rpm_dir/$vxmlinterpreter_branch
		cp -rf delivery/*.rpm $rpm_dir/$vxmlinterpreter_branch
	else
		echo "M&I vxmlinterpreter build failed $?"
	fi
else
	echo "Error: SVN Checkout failed $?"
fi
}

annlab (){
annlab_branch=annlab_mrf$bulnum
if [ -d $annlab_branch ]; then
	echo "$workspace/$annlab_branch is already exist, Going for svn update.."
      	sleep 5
     	cd $annlab_branch
   	svn update
else
	echo "Going for svn checkout of $annlab_branch_branch directory.."
	sleep 5
    	svn co http://svn.radisys.com/svn/nmrf/annlab/branches/$annlab_branch
	cd $annlab_branch
fi
if [ $?=0 ]; then
	./compile.sh 
	cd $workspace/$annlab_branch/
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
	cd ../Identity/; ./make-rpm.sh
	cd ../Monitoring/; ./make-rpm.sh
	cd ../../CloudPrepare/Cleaner; ./make-rpm.sh
	cd ../../CloudAddon/rhcs2node/rpm/rhcs2node/; chmod -R 777 .; ./makerpm
else
      	echo "Error: SVN Checkout failed $?"
fi
}

mi_system_delivery (){
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
        cd miToolbox; ./make-rpm.sh
	cd ../platform-update; ./make-rpm.sh
	cd ../MRF-Remote-Tools; ./make-rpm.sh
	cd ../configMergeTool; ./make-rpm.sh
	cd ../backup-restore; ./make-rpm.sh
	cd ../hardening; ./make-rpm.sh
	cd ../monitoring-tools; ./make-rpm.sh
	cd ../MRF-Remote-Upgrade; ./make-rpm.sh
	cd ../syslog2amm-catalog; ./make-rpm.sh
	cd ../hardening-catalogs; ./make-rpm.sh
	cd ../upgrade-tools; ./make-rpm.sh
	cd ../mcdp-update; ./make-rpm.sh
	cd ../mrfDoxygen; ./make-rpm.sh
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
else
        echo "Error: SVN Checkout failed $?"
fi
}





mi_python_patch (){
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
else
	echo "Error: SVN Checkout failed $?"
fi
}


mi_drdb (){
        echo "Mi drdb"
        echo "$bulnum"
        #svn co http://svn.radisys.com/svn/nmrf/mediaserver/branches/mediaserver_mrf$bulnum
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
        #chmod 777 MainMakefile; ./MainMakefile
else
     	echo "Error: SVN Checkout failed $?"
fi
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
else
  	echo "Error: SVN Checkout failed $?"
fi

}

help (){
        echo "Choose the component"
        echo "interpreter"
	echo "hbmr-imr"
	echo "mcdp"
	echo "weboam"
	echo "mpm"
	echo "vxmlinterpreter"
	echo "annlab"
	echo "cloud"
	echo "checkhostsconfig"
	echo "bulkconfig"
	echo "dri_mrf"
	echo "initmrf"
	echo "initsu"
	echo "healthcheck"
	echo "healthcheck_plugin_validatenf"
	echo "healthcheck_plugin_vsippcall"
	echo "systemdelivery"
	echo "httpconf"
	echo "checktools"
	echo "datatools"
	echo "install"
	echo "mrfmaa"
	echo "mrfsqlbk"
	echo "smartdhook"
	echo "sutool"
}

# Main Function starts

if [ "$1" == "all" ]; then	#if block starts
	# Calling all the component
	interpreter
	hbmr-imr
	mcdp
	weboam
	mpm
	vxmlinterpreter	
	annlab
	mi_cloud
	mi_checkhostsconfig
	mi_bulkconfig
	mi_dri_mrf
	mi_initmrf
	mi_initsu
	mi_healthcheck
	mi_healthcheck_plugin_validatenf
	mi_healthcheck_plugin_vsippcall
	mi_system_delivery
	mi_httpconf
	mi_checktools
	mi_datatools
	mi_install
	mi_mrfmaa
	mi_mrfsqlbk
	mi_smartdhook
	mi_sutool

elif [ "$1" == "interpreter" ]; then

	interpreter	#Calling a function

elif [ "$1" == "hbmr-imr" ]; then

	hbmr-imr	#Calling a function

elif [ "$1" == "mcdp" ]; then

	mcdp	#Calling a function

elif [ "$1" == "weboam" ]; then

	weboam	#Calling a function

elif [ "$1" == "mpm" ]; then

	mpm		#Calling a function

elif [ "$1" == "vxml" ]; then

	vxmlinterpreter 	#Calling a function

elif [ "$1" == "annlab" ]; then

	annlab	#Calling a function

elif [ "$1" == "mi" ]; then

        mi  #Calling a function

elif [ "$1" == "bulkconfig" ]; then

        mi_bulkconfig  #Calling a function

elif [ "$1" == "checkhostsconfig" ]; then

        mi_checkhostconfig  #Calling a function

elif [ "$1" == "cloud" ]; then

        mi_cloud  #Calling a function

elif [ "$1" == "drimrf" ]; then

        mi_dri_mrf  #Calling a function

elif [ "$1" == "initmrf" ]; then

        mi_initmrf  #Calling a function

elif [ "$1" == "initsu" ]; then

        mi_initsu  #Calling a function

elif [ "$1" == "healthcheck" ]; then

        mi_healthcheck  #Calling a function

elif [ "$1" == "healthcheck_plugin_validatenf" ]; then

        mi_healthcheck_plugin_validatenf  #Calling a function

elif [ "$1" == "healthcheck_plugin_vsippcall" ]; then

        mi_healthcheck_plugin_vsippcall  #Calling a function

elif [ "$1" == "httpconf" ]; then

        mi_httpconf  #Calling a function

elif [ "$1" == "checktools" ]; then

        mi_checktools  #Calling a function

elif [ "$1" == "datatools" ]; then

        mi_datatools  #Calling a function

elif [ "$1" == "install" ]; then

        mi_install  #Calling a function

elif [ "$1" == "mrfmaa" ]; then

        mi_mrfmaa  #Calling a function

elif [ "$1" == "mrfsqlbk" ]; then

        mi_mrfsqlbk  #Calling a function

elif [ "$1" == "smartdhook" ]; then

        mi_smartdhook  #Calling a function

elif [ "$1" == "sutool" ]; then

        mi_sutool  #Calling a function

elif [ "$1" == "systemdelivery" ]; then

        mi_system_delivery  #Calling a function

elif [ "$1" == "-h" ]; then

        help  #Calling a function

else	#else block

	echo "Enter correct component name"

fi #end of if


