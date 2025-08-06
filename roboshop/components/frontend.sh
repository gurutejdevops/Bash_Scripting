#!/bin/bash

set -e

#Validate the user
USER_ID="$(whoami)"
COMPONENT=frontend
LOGFILE=/tmp/${COMPONENT}.log

if [ ${USER_ID} != root ] ; then

    echo -e "\e[31m script is expected to execute by the root user or with a sudo privilege \e[0m 
    \n \t Example: \n\t sudo wrapper.sh ${COMPONENT}.sh"
    exit 1
fi

stat() {
    if [ $1 -eq 0 ]; then

        echo -e "\e[32m success \e[0m"
    else

        echo -e "\e[31m Failure \e[0m"
    fi 

}

echo -e "\e[32m Configuring ${COMPONENT} \e[0m \n"

echo -e -n "\e[33m Installing ${COMPONENT} \e[0m"

yum install nginx -y &>> ${LOGFILE}

stat $?

echo -n "starting nginx"
systemctl enable nginx &>> ${LOGFILE}
systemctl start nginx  &>> ${LOGFILE}

stat $?

echo -n "Downloading the ${COMPONENT} component"

curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"

stat $?

echo -n "Clean up ${COMPONENT}:"
cd /usr/share/nginx/html
rm -rf *   &>> ${LOGFILE}

stat $?

echo -n "Extracting ${COMPONENT}:"
unzip /tmp/${COMPONENT}.zip  &>> ${LOGFILE}

stat $?

echo -n "sorting the ${COMPONENT} files:"
mv ${COMPONENT}-main/* .
mv static/* .
rm -rf ${COMPONENT}-main README.md  &>> ${LOGFILE}
mv localhost.conf /etc/nginx/default.d/roboshop.conf

stat $?

echo -n "Restarting ${COMPONENT}:"

systemctl daemon-reload   &>> ${LOGFILE}
systemctl restart nginx   &>> ${LOGFILE}

stat $?

