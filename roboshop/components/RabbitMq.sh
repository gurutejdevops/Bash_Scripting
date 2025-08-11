#!/bin/bash

USER_ID="$(whoami)"
COMPONENT=rabbitmq
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

<<COMMENT
echo -n "Erlang is a dependency that is needed for RabbitMQ:"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash   &>> ${LOGFILE}
stat $?

echo -n "Setup YUM repositories for RabbitMQ:"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash   &>> ${LOGFILE}
stat $?

echo -n "Install RabbitMQ:"
yum install rabbitmq-server -y  &>> ${LOGFILE}
stat $?

echo -n "Start RabbitMQ:"
systemctl enable ${COMPONENT}-server   &>> ${LOGFILE}
systemctl start ${COMPONENT}-server    &>> ${LOGFILE}
systemctl status ${COMPONENT}-server -l   &>> ${LOGFILE}
stat $?
COMMENT

sudo rabbitmqctl list_users | grep roboshop &>> ${LOGFILE}

if [ $? -ne 0 ] ; then 
    echo -n "Creating ${COMPOMENT} user account :"
    rabbitmqctl add_user roboshop roboshop123 &>> ${LOGFILE}
    stat $? 
fi 

echo -n "Configuring the permissions :"
rabbitmqctl set_user_tags roboshop administrator     &>> ${LOGFILE}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"     &>> ${LOGFILE}
stat $?

echo -e "\e[35m ${COMPONENT} Installation Is Completed \e[0m \n"
