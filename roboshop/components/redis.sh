#!/bin/bash

COMPONENT=redis
USER_ID="$(whoami)"
LOGFILE=/tmp/${COMPONENT}.log



if [ "${USER_ID}" != "root" ]; then

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

echo -e -n "\e[33m Configuring ${COMPONENT} repo \e[0m"
curl -L https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/redis.repo -o /etc/yum.repos.d/${COMPONENT}.repo &>> ${LOGFILE}
stat $?

echo -e -n "\e[33m Installing ${COMPONENT} repo \e[0m"
yum install redis-6.2.13 -y &>> ${LOGFILE}
stat $?

echo -n "Enabling the visibility ${COMPONENT}:"
sed -ie 's/127.0.0.1/0.0.0.0/g' /etc/${COMPONENT}.conf
stat $?

echo -n "starting ${COMPONENT}"
systemctl enable ${COMPONENT}      &>> ${LOGFILE}
systemctl start ${COMPONENT}       &>> ${LOGFILE}
systemctl status ${COMPONENT} -l   &>> ${LOGFILE}

echo -e -n "\e[33m ${COMPONENT} installation is completed \e[0m"
