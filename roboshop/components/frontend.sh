#!/bin/bash

#Validate the user

USER_ID="$(id -u)"

if [ ${USER_ID} -ne 0 ] ; then

    echo -e "\e[31m script is expected to execute by the root user or with a sudo privilege \e[0m 
    \n \t Example: \n\t sudo wrapper.sh frontend.sh"
    exit 1
fi

echo -e "\e[32m Configuring Fronend \e[0m"

echo -e "\e[33m Installing Frontend \e[0m"

yum install nginx -y &>> /tmp/frontend.log

if [ echo $? -eq 0 ]; then

    echo -e "\e[32m success \e[0m"
else

    echo -e "\e[31m Failure \e[0m"
fi 