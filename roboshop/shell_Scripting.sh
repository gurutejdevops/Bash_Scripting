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