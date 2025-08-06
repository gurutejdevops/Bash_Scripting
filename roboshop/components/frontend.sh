#!/bin/bash
#Validate the user
USER_ID="$(id -u)"

if [ ${USER_ID} -ne 0 ] ; then

    echo -e "\e[31m script is expected to execute by the root user or with a sudo privilege \e[0m 
    \n \t Example: \n\t sudo wrapper.sh frontend.sh"
    exit 1
fi

stat() {
    if [ $1 -eq 0 ]; then

        echo -e "\e[32m success \e[0m"
    else

        echo -e "\e[31m Failure \e[0m"
    fi 

}

echo -e "\e[32m Configuring Fronend \e[0m \n"

echo -e -n "\e[33m Installing Frontend \e[0m"

yum install nginx -y &>> /tmp/frontend.log

stat $?

echo -n "starting nginx"
systemctl enable nginx &>> /tmp/frontend.log
systemctl start nginx  &>> /tmp/frontend.log

stat $?

echo -n "Downloading the frontend component"

curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

stat $?

echo -n "Clean up Frontend:"
cd /usr/share/nginx/html
rm -rf *   &>> /tmp/frontend.log

stat $?

echo -n "Extracting Frontend:"
unzip /tmp/frontend.zip  &>> /tmp/frontend.log

stat $?

echo -n "sorting the frontend files:"
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md  &>> /tmp/frontend.log
mv localhost.conf /etc/nginx/default.d/roboshop.conf

stat $?

echo -n "Restarting Frontend:"

systemctl daemon-reload   &>> /tmp/frontend.log
systemctl restart nginx   &>> /tmp/frontend.log

stat $?

