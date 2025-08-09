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

echo -n "Create Application User:"
rabbitmqctl add_user ${APPUSER} roboshop123
rabbitmqctl set_user_tags ${APPUSER} administrator
rabbitmqctl set_permissions -p / ${APPUSER} ".*" ".*" ".*"
stat $?
