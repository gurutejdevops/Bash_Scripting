#!/bin/bash
#Validate the user
USER_ID="$(id -u)"

if [ ${USER_ID} -ne 0 ] ; then

    echo -e "\e[31m script is expected to execute by the root user or with a sudo privilege \e[0m 
    \n \t Example: \n\t sudo wrapper.sh frontend.sh"
    exit 1
fi

stat() {
    if [ $? -eq 0 ]; then

        echo -e "\e[32m success \e[0m"
    else

        echo -e "\e[31m Failure \e[0m"
    fi 

}

echo -e "\e[32m Configuring Fronend \e[0m \n"

echo -e -n "\e[33m Installing Frontend \e[0m"

yum install nginx -y &>> /tmp/frontend.log

stat

echo -n "starting nginx"
systemctl enable nginx &>> /tmp/frontend.log
systemctl start nginx  &>> /tmp/frontend.log

stat

echo -n "Downloading the frontend component"

curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

stat