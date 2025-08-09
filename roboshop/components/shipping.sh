#!/bin/bash

COMPONENT=shipping
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
    fi
}

echo -n "Installation of maven:"
yum install maven -y  &>> ${LOGFILE}
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
cd /home/${APPUSER}
rm -rf ${COMPONENT} &>> ${LOGFILE}
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
unzip -o /tmp/${COMPONENT}.zip   &>> ${LOGFILE}
mv ${COMPONENT}-main ${COMPONENT}
chown -R ${APPUSER}:${APPUSER} /home/${APPUSER}/${COMPONENT}/  &>> ${LOGFILE}
cd ${COMPONENT}
mvn clean package   &>> ${LOGFILE}
mv target/${COMPONENT}-1.0.jar ${COMPONENT}.jar  &>> ${LOGFILE}
stat $?

echo -n -e "\e[91m Configuring the ${COMPONENT} file \e[0m"
sed -ie 's/CARTENDPOINT/172.31.42.168/'  /home/${APPUSER}/${COMPONENT}/systemd.service
sed -ie 's/DBHOST/172.31.35.72/'  /home/${APPUSER}/${COMPONENT}/systemd.service 
mv /home/${APPUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
stat $?

echo -n -e "\e[92m restarting the ${COMPONENT} file \e[0m"
systemctl daemon-reload  &>> ${LOGFILE}
systemctl restart ${COMPONENT}    &>> ${LOGFILE}
systemctl start ${COMPONENT}      &>> ${LOGFILE}
systemctl enable ${COMPONENT}    &>> ${LOGFILE}
stat $?

echo -n -e "\e[93m Installation ${COMPONENT} completed \e[0m"