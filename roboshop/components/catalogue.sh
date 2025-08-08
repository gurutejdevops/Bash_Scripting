#!/bin/bash

USER_ID="$(whoami)"
COMPONENT=catalogue
LOGFILE=/tmp/${COMPONENT}.log
APPUSER=roboshop


if [ ${USER_ID} != root ]; then

    echo -e "\e[31m script is expected to execute by the root user or with a sudo privilege \e[0m 
    \n \t Example: \n\t sudo wrapper.sh ${COMPONENT}.sh"
    exit 1

fi

stat() {

    if [ $1 -eq 0 ]; then

        echo -e "\e[32m success \e[0m"
    else
        echo -e "\e[35m Failure \e[0m"
    fi
}


echo -e "\e[35m Configuration ${COMPONENT}...........! \e[0m"

if [ -f /etc/yum.repos.d/nodesource*.repo ]; then

    echo "Repo already exists. Skipping installation." &>> ${LOGFILE}
    stat $?
else
    yum install -y https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm &>> ${LOGFILE}
    stat $?
fi

echo -n -e "\e[37m Configuration ${COMPONENT} repo \e[0m"
yum install nodejs -y  &>> ${LOGFILE}
stat $?

echo -n -e "\e[38m Creating Application User Account \e[0m: \n"

id ${APPUSER}  &>> ${LOGFILE}
if [ $? -eq 0 ]; then

    echo "Application user is already Available"
    stat 0
else
    useradd roboshop
    stat $?
fi





<<COMMENT
echo "I am catalogue"

# yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
# yum install nodejs -y
# useradd roboshop
#which ti roboshop user to perform below actions
$ curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
$ cd /home/roboshop
$ unzip /tmp/catalogue.zip
$ mv catalogue-main catalogue
$ cd /home/roboshop/catalogue
$ npm install
$ vim systemd.servce
# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue
# systemctl status catalogue -l
COMMENT