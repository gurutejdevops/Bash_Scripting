#!/bin/bash
# Description: 
# Author:
# Date Created:
# Version: 
# Date Modified:
read -p "Enter the number1:" num1
read -p "Enter the number2:" num2
read -p "Enter the number3:" num3
if [[ $num1 -gt $num2 && $num1 -gt $num3 ]] then
    echo "$num1 is greater"
elif [[ $num2 -gt $num1 && $num2 -gt $num3 ]] then
    echo "$num2 is greater"
else
    echo "$num3 is greater"
fi