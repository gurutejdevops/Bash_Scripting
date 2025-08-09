#!/bin/bash

COMPONENT=mysql
LOGFILE=/tmp/${COMPONENT}.log
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
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo &>> ${LOGFILE}
stat $?

echo -e -n "\e[32m Installing ${COMPONENT}...........! \e[0m "
yum install mysql-community-server -y  &>> ${LOGFILE}
stat $?


<<COMMENT
echo -n "starting ${COMPONENT}"
systemctl enable ${COMPONENT}      &>> ${LOGFILE}
systemctl restart ${COMPONENT}      &>> ${LOGFILE}
systemctl start ${COMPONENT}       &>> ${LOGFILE}
systemctl status ${COMPONENT} -l   &>> ${LOGFILE}
COMMENT