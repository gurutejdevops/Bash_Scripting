#!/bin/bash

set -e

COMPONENT=cart
LOGFILE=/tmp/${COMPONENT}.log
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
         exit 2
    fi
}

echo -e -n "\e[32m Configuration ${COMPONENT}...........! \e[0m "
if [ -f /etc/yum.repos.d/nodesource*.repo ]; then

    echo "Repo already exists. Skipping installation."
else
    yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y &>> ${LOGFILE}   
fi
stat $?

echo -e -n "\e[32m Installation of NodeJs...........! \e[0m "
yum install nodejs -y &>> ${LOGFILE}
stat $?

echo -e -n "\e[32m Creation of Application user \e[0m "

id ${APPUSER}  &>> ${LOGFILE}

if [ $? -eq 0 ] ; then
    echo "Application user is already available"
    stat $?
else
    useradd roboshop
    echo "user created"
    stat $?
fi

stat $?

echo -n -e "\e[35m Downloading the ${COMPONENT} \e[0m :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip" &>> ${LOGFILE}
stat $?

echo -n -e "\e[36m Copying the ${COMPONENT} to ${APPUSER} home directory \e[0m :"
cd /home/${APPUSER}
rm -rf ${COMPONENT} &>> ${LOGFILE}
unzip -o /tmp/${COMPONENT}.zip &>> ${LOGFILE}
stat $?

echo -n -e "\e[36m Changing the ownership \e[0m :"
mv ${COMPONENT}-main ${COMPONENT}
chown -R ${APPUSER}:${APPUSER} /home/${APPUSER}/${COMPONENT}/
stat $?

echo -n -e "\e[90m Generating Artifacts \e[0m"
cd /home/${APPUSER}/${COMPONENT}/  
npm install  &>> ${LOGFILE}
stat $?

echo -n -e "\e[91m Configuring the ${COMPONENT} file \e[0m"
sed -ie 's/REDIS_ENDPOINT/172.31.39.200/'  /home/${APPUSER}/${COMPONENT}/systemd.service
sed -ie 's/CATALOGUE_ENDPOINT/172.31.47.227/'  /home/${APPUSER}/${COMPONENT}/systemd.service 
mv /home/${APPUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n -e "\e[92m restarting the ${COMPONENT} file \e[0m"
systemctl daemon-reload  &>> ${LOGFILE}
systemctl restart ${COMPONENT}    &>> ${LOGFILE}
systemctl start ${COMPONENT}      &>> ${LOGFILE}
systemctl enable ${COMPONENT}    &>> ${LOGFILE}
stat $?

echo -n -e "\e[93m Installation ${COMPONENT} completed \e[0m"




