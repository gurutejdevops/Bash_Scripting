#!/bin/bash
# Description: 
# Author:
# Date Created:
# Version: 
# Date Modified:


COMPONENT=$1
ENV=$2
HOSTEDZONEID="Z06425167V0RQT8K6CDU"
Instance_tpe=t2.micro
Key_Name=New_pem_aws_key

if [ -z $1 ] || [ -z $2 ]; then
    echo -e "\e[31m The component name is needed\e[0m"
    echo -e "\e[32m Example $ bash shell_Scripting post\e[0m"
    exit 1
fi 

#AMI_ID=ami-0ad3d11156336bf7f
AMI_ID="$(aws ec2 describe-images --filters "Name=name,Values=aws-parallelcluster-3.7.1-centos7-hvm-x86_64-202309151532 2023-09-15T15-36-15.606Z" | jq ".Images[].ImageId" | sed -e 's/"//g')"
security_group="$(aws ec2 describe-security-groups --filters Name=group-name,Values=Practice-Allow-all | jq ".SecurityGroups[].GroupId"| sed -e 's/"//g')"

create_ec2() {

PRIVATE_IP=$(aws ec2 run-instances \
    --image-id ${AMI_ID} \
    --count 1 \
    --instance-type ${Instance_tpe} \
    --key-name ${Key_Name} \
    --security-group-ids ${security_group} \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}-${ENV}}]" | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')

echo "The private IP of $COMPONENT is ${PRIVATE_IP}"

echo -e "Creating DNS Record of ${COMPONENT}: "

    sed -e "s/COMPONENT/${COMPONENT}-${ENV}/"  -e "s/IPADDRESS/${PRIVATE_IP}/" route53.json  > /tmp/r53.json 

    aws route53 change-resource-record-sets --hosted-zone-id $HOSTEDZONEID --change-batch file:///tmp/r53.json
    echo -e "\e[36m **** Creating DNS Record for the $COMPONENT has completed **** \e[0m \n\n"

}

if [ $1 == all ]; then

    for component in mongodb catalogue; do
    COMPONENT=$component
    create_ec2
    done
else
    create_ec2
fi
