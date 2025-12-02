#!/bin/bash

user_id="$(whoami)"

if [ ${user_id} != root ]; then 
    echo  -e "\e[32m script expected to executef by root user or sudo access \e[0m"
else 
    echo "proceed with the execution"
fi
