#!/bin/bash

comp=$1
bulnum=$2


workspace=`pwd`
rpm_dir="$workspace/rpm_dir"

#Declaring a function


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
        if [ -d $weboam_branch ]
        then
                echo "$workspace/$weboam_branch is already exist, Going for svn update.."
                sleep 5
                cd $weboam_branch
                svn update
        else
                echo "Going for svn checkout of $weboam_branch directory.."
                sleep 5
                svn co http://svn.radisys.com/svn/nmrf/weboam/branches/$weboam_branch
        fi

        if [ $?=0 ]
         then
		cd $weboam_branch;
		chmod -R 775 patch_mngt
		PWD=`pwd`
		export SOURCEDIR=$PWD/../..
		export WORKDIR=$PWD
                make all; make gtar
                if [ $?=0 ]
                then
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
	#echo "$workspace/$rpm_branch is already exist"

	if [ -d $mpm_branch ]
	then
		echo "$workspace/$mpm_branch is already exist, Going for svn update.."
		sleep 5
		cd $mpm_branch
		svn update
	else
		echo "Going for svn checkout of $mpm_branch directory.."
		sleep 5 
		svn co http://svn.radisys.com/svn/nmrf/mpm/branches/$mpm_branch
	fi
		
        if [ $?=0 ]
	 then
                cd $mpm_branch; cmake .; make
                if [ $?=0 ] 
		then
                        echo "M&I mpm build passed successfully"
			chmod u+x mkrpm; ./mkrpm
			if [ -d $rpm_dir/$mpm_branch ]
			then
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

	echo "VXMLinterpreter"
	echo "$bulnum"
	vxmlinterpreter_branch=vxmlinterpreter_mrf$bulnum
	if [ -d $vxmlinterpreter_branch ]
        then
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
	if [ $?=0 ]
        then
		JAVA_HOME=/opt/java
		ant -f build.xml
                if [ $?=0 ]
                then
                        echo "M&I vxmlinterpreter  build passed successfully"
                        chmod u+x mkrpm; ./mkrpm
                else
                        echo "M&I vxmlinterpreter build failed $?"
                fi
        else
                echo "Error: SVN Checkout failed $?"
        fi

}

annlab (){
	echo "Annlab"
	echo "$bulnum"
	#svn co http://svn.radisys.com/svn/nmrf/mediaserver/branches/mediaserver_mrf$bulnum
}

mi (){
        echo "Mi"
        echo "$bulnum"
	#svn co http://svn.radisys.com/svn/nmrf/mediaserver/branches/mediaserver_mrf$bulnum
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
}

# Main Function starts

if [ "$1" == "all" ]	#if block starts
then
	# Calling all the component

	interpreter
	hbmr-imr
	mcdp
	weboam
	mpm
	vxmlinterpreter	
	annlab
	mi

elif [ "$1" == "interpreter" ]
then

	interpreter	#Calling a function

elif [ "$1" == "hbmr-imr" ]
then

	hbmr-imr	#Calling a function

elif [ "$1" == "mcdp" ]
then

	mcdp	#Calling a function

elif [ "$1" == "weboam" ]
then

	weboam	#Calling a function
elif [ "$1" == "mpm" ]
then

	mpm		#Calling a function

elif [ "$1" == "vxml" ]
then

	vxmlinterpreter 	#Calling a function

elif [ "$1" == "annlab" ]
then

	annlab	#Calling a function

elif [ "$1" == "mi" ]
then

        mi  #Calling a function

elif [ "$1" == "-h" ]
then

        help  #Calling a function

else	#else block

echo "Enter correct component name"

fi #end of if





