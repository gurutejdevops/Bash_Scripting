#!/bin/bash

#commands to execute scripts
#bash <scriptname.sh>
#sh <scriptname.sh>
#./<scriptname.sh>

a=10
b=10
date="$(date +%D)"
dir="$(pwd)"
session_count="$(who | wc -l)"
argument1=$1
argument2=$2

echo "The date is ${date}"
echo "The current dir is ${dir}"
echo "The session_count is ${session_count}"
echo "The argument1 is ${argument1}"
echo "The argument2 is ${argument2}"
echo "The file name is $0 "
echo "The PID is $$"
echo "The no of arguments is: $#"
echo "The arguments are $*"
echo "The value of a is ${a}"
echo "The value of b is ${b}"
echo "The value of b is ${x}"
echo -e "\e[32m Welcome to \nScript learning \e[0m"

case $3 in 
    start)
        echo "payment service started"
        ;;
    stop)
        echo "payment services stopped"
        ;;
    *)
        echo "Please select start or stop"
        ;;
esac

if [ $4 -eq 4 ]; then
    echo "Yes"
elif [ $4 -ne 4 ]; then
    echo "NO"
else
    echo "Better luck next time"
fi

VAR="$(cat wrapper.sh)"

if [ -n $VAR ]; then
    echo "YES CONTENT IS THERE IN THE FILE"
else
    echo "no content"
fi

if [ -f ~/passwd ]; then
    echo "passwd file is avilable"
else
    echo "not there passwd file"
fi