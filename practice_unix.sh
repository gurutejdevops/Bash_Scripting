#!/bin/bash
echo "Hello World"
a=10
b=20
c=xyz
echo -e "\e[33m The value of a is: ${a} \e[0m"
echo -e "\e[32m The value of b is: ${b} \e[0m"
echo -e "\e[43;32m The value of c is: ${c} \e[0m"
echo -e "\e[32m The value of x is: ${x} \e[0m"
date="$(date +%D)"
session_count="$(who | wc -l)"
dir="$(pwd)"
echo -e "\e[32m The date is ${date} \e[0m"
echo -e "\e[32m The session_count is ${session_count} \e[0m"
echo -e "\e[33m The dir is ${dir} \e[0m"


