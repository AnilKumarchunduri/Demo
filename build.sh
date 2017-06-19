#!/bin/bash

COMPONENT_NAME=$1
BRANCH_NAME=$2
WORKSPACE=$3
RPM_DIR=${WORKSPACE}/${COMPONENT_NAME}/RPMs_${BRANCH_NAME}
mkdir -p ${WORKSPACE}/${COMPONENT_NAME}
mkdir -p ${RPM_DIR}
COMP=$(echo $COMPONENT_NAME | tr '[A-Z]' '[a-z]')
cd ${WORKSPACE}/${COMPONENT_NAME}
chmod -R 777 ${BRANCH_NAME}















if  [ ${BRANCH_NAME} == trunk ]; then
	if [  -d ${BRANCH_NAME} ]; then
		cd ${BRANCH_NAME}
		svn update
        echo "test1"
	else
		svn co http://svn.radisys.com/svn/nmrf/${COMPONENT_NAME}/trunk --username jenkins ${WORKSPACE}/${COMPONENT_NAME}/${BRANCH_NAME}
		cd  ${WORKSPACE}/${COMPONENT_NAME}/
        chmod -R 777 ${BRANCH_NAME}
        cd ${BRANCH_NAME}
        echo "test2"
	fi
else
	if [ -d ${BRANCH_NAME} ]; then
		cd ${BRANCH_NAME}
		svn update
        echo "test3"
	else
		svn co http://svn.radisys.com/svn/nmrf/${COMPONENT_NAME}/branches/${COMP}_mrf${BRANCH_NAME} --username jenkins ${WORKSPACE}/${COMPONENT_NAME}/${BRANCH_NAME}
        cd  ${WORKSPACE}/${COMPONENT_NAME}/
        chmod -R 777 ${BRANCH_NAME}
		cd ${BRANCH_NAME}
        echo "test4"
	fi
fi
