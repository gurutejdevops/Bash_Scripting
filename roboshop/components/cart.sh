#!/bin/bash

set -e

COMPONENT=cart
LOGFILE=/tmp/{COMPONENT}.log
APPUSER=roboshop
USER_ID="$(id -u)"

if [ ${USER_ID} -ne 0 ]; then
    echo -e "\e[31m script is expected to execute by the root user or with a sudo privilege \e[0m 
    \n \t Example: \n\t sudo wrapper.sh ${COMPONENT}.sh"
    exit 1
fi

stat() {
    if [ $1 -eq 0 ]; then
         echo -e "\e[32m success \e[0m"
    else
         echo -e "\e[31m success \e[0m"
    fi
}

echo -e "\e[32m Configuration ${COMPONENT}...........! \e[0m "
if [ -f /etc/yum.repos.d/nodesource*.repo ]; then

    echo "Repo already exists. Skipping installation."
else
    yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y &>> ${LOGFILE}   
fi
stat $?

echo -e "\e[32m Installation of NodeJs...........! \e[0m "
yum install nodejs -y &>> ${LOGFILE}
stat $?

echo -e "\e[32m Creation of Application user \e[0m "

id ${APPUSER}  &>> ${LOGFILE}

if [ $? -eq 0 ] ; then
    echo "Application user is already available"
    stat $?
else
    useradd roboshop
    echo "user created"
    stat $?
fi


