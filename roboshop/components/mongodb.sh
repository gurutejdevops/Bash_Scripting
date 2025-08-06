#!/bin/bash

set -e

#Validate the user
USER_ID="$(whoami)"
COMPONENT=mongodb
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

echo -e -n "\e[33m Configuring ${COMPONENT} repo \e[0m"

curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo

stat $?

echo -e -n "\e[33m Installing ${COMPONENT} repo \e[0m"

yum install -y mongodb-org &>> ${LOGFILE}

echo -n "Enabling the visibility ${LOGFILE}:"
sed -ie 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf

stat $?

echo -n "starting ${COMPONENT}"

systemctl enable mongod &>> ${LOGFILE}
systemctl start mongod &>> ${LOGFILE}

stat $?

echo -n "Download the ${COMPONENT} schema:"

curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"

stat $?

echo -n "Extracting the ${COMPONENT} schema:"

cd /tmp
unzip mongodb.zip &>> ${LOGFILE}

stat $?


echo -n "Inject the ${COMPONENT} schema:"
cd mongodb-main
mongo < catalogue.js  &>> ${LOGFILE}
mongo < users.js      &>> ${LOGFILE}

stat $?

echo -e -n "\e[33m ${COMPONENT} installation is completed \e[0m"



# curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"

# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js


<<COMMENT
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
COMMENT

