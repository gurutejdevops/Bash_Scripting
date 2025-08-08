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


echo -e "\e[32m Configuration ${COMPONENT}...........! \e[0m "

if [ -f /etc/yum.repos.d/nodesource*.repo ]; then

    echo "Repo already exists. Skipping installation."
    
else
    yum install -y https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm &>> ${LOGFILE}
    
fi
stat $?

echo -n -e "\e[33m Configuration ${COMPONENT} repo \e[0m "
yum install nodejs -y  &>> ${LOGFILE}
stat $?

echo -n -e "\e[34m Creating Application User Account \e[0m :"

id ${APPUSER}  &>> ${LOGFILE}
if [ $? -eq 0 ]; then

    echo "Application user is already Available"
    stat 0
else
    useradd roboshop
    stat $?
fi

echo -n -e "\e[35m Downloading the ${COMPONENT} \e[0m :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?

echo -n -e "\e[36m Copying the ${COMPONENT} to ${APPUSER} home directory \e[0m :"
cd /home/${APPUSER}
rm -rf ${COMPONENT} &>> ${LOGFILE}
unzip -o /tmp/${COMPONENT}.zip &>> ${LOGFILE}
stat $?

echo -n -e "\e[37m Changing the ownership: \e[0m"
mv ${COMPONENT}-main ${COMPONENT}
chown -R ${APPUSER}:${APPUSER} /home/${APPUSER}/${COMPONENT}/
stat $?

echo -n -e "\e[90m Generating Artifacts \e[0m"
cd /home/${APPUSER}/${COMPONENT}/  
npm install  &>> ${LOGFILE}
stat $?

echo -n -e "\e[91m Configuring the ${COMPONENT} file \e[0m"
sed -ie 's/MONGO_DNSNAME/guru/' /home/${APPUSER}/${COMPONENT}/systemd.service
mv /home/${APPUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

<<COMMENT
echo -n -e "\e[92m restarting the ${COMPONENT} file \e[0m"
systemctl daemon-reload       &>> ${LOGFILE}
systemctl start ${COMPONENT}  &>> ${LOGFILE}
systemctl enable ${COMPONENT}  &>> ${LOGFILE}
systemctl status ${COMPONENT} &>> ${LOGFILE}
stat $?

echo -n -e ""\e[93m Installation ${COMPONENT} completed \e[0m"
COMMENT




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