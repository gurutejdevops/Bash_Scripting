#!/bin/bash

COMPONENT=payment
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
         echo -e "\e[31m Failure \e[0m"
         exit 2
    fi
}

echo -n "Install Python 3:"
yum install python36 gcc python3-devel -y
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

echo -n "Download the repo:"
cd /home/${APPUSER}
rm -rf ${COMPONENT} &>> ${LOGFILE}  
curl -L -s -o /tmp/payment.zip "https://github.com/stans-robot-project/payment/archive/main.zip"  &>> ${LOGFILE}
unzip -o /tmp/${COMPONENT}.zip &>> ${LOGFILE}
mv ${COMPONENT}-main ${COMPONENT}
chown -R ${APPUSER}:${APPUSER} /home/${APPUSER}/${COMPONENT}/  &>> ${LOGFILE}
stat $?

echo -n "Install the dependencies:"
cd /home/roboshop/payment 
pip3 install -r requirements.txt  &>> ${LOGFILE}
stat $?

USERID=$(id -u roboshop)
GROUPID=$(id -g roboshop)

echo -n "Updating the uid and gid in the ${COMPONENT}.ini file"
sed -i -e "/^uid/ c uid=${USERID}" -e "/^gid/ c gid=${GROUPID}" /home/${APPUSER}/${COMPONENT}/${COMPONENT}.ini
stat $?

echo -n -e "\e[91m Configuring the ${COMPONENT} file \e[0m"
sed -ie 's/CARTHOST/172.31.42.168/'  /home/${APPUSER}/${COMPONENT}/systemd.service
sed -ie 's/USERHOST/172.31.39.39/'  /home/${APPUSER}/${COMPONENT}/systemd.service 
sed -ie 's/AMQPHOST/172.31.35.99/'  /home/${APPUSER}/${COMPONENT}/systemd.service 
mv /home/${APPUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n -e "\e[91m Configuring the ${COMPONENT} file \e[0m"
systemctl daemon-reload
systemctl enable payment 
systemctl start payment
systemctl status payment -l
stat $?
