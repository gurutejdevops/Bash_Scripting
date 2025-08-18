#!/bin/bash

#commands to execute scripts
#bash <scriptname.sh>
#sh <scriptname.sh>
#./<scriptname.sh>

a=10
b=10
date="${date +%D}"
dir="${pwd}"
session_count="${who | wc -l}"

echo "\e[30m The date is ${date}\e[0m"
echo "\[31m The current dir is ${dir} \e[0m"
echo "The session_count is ${session_count}"
echo "The value of a is ${a}"
echo "The value of b is ${b}"
echo "The value of b is ${x}"
echo -e "\e[32m Welcome to \nScript learning \e[0m"