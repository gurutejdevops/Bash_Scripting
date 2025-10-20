#!/bin/bash

#commands to execute scripts
#bash <scriptname.sh>
#sh <scriptname.sh>
#./<scriptname.sh>

# echo $SHELL
# echo "Welcome to Linux Shell Scripting practice again"
# echo -e "\e[32m welcome to \n Linux Shell Scripting \n practice again \e[0m"
# echo -e "\e[33m ala kadhu raa \n erripuka \n tension akuva tesukovaddu ra \e[0m"
# echo -e "\e[42;33m Good for health \e[0m"

# # Variables
# a=10
# b=20
# c=30

# echo -e "\e[32m The value of a is ${a} \e[0m"
# echo -e "\e[33m The value of b is ${b} \e[0m"
# echo -e "\e[34m The value of c is ${c} \e[0m"
# echo -e "\e[35m The value of y is ${y} \e[0m"

# date="$(date)"
# session_count="$(who | wc -l)"
# dir="$(pwd)"

# echo -e "\e[32m The date is ${date} \e[0m"
# echo -e "\e[33m The session_count is ${session_count} \e[0m"
# echo -e "\e[34m The current dir is ${dir} \e[0m"

# The Default Arguments

# echo -e "\e[32m The script name is $0 \e[0m"
# echo -e "\e[33m The Value of argument1 is $1 \e[0m"
# echo -e "\e[34m The value of argument2 is $2 \e[0m"
# echo -e "\e[35m The no.of agruments passed is $# \e[0m"
# echo -e "\e[36m The arguments are $@ \e[0m"
# echo -e "\e[37m the PID is $$ \e[0m"
# echo -e "\e[38 The result of last command is $? \e[0m"

# read -p "Enter the Surname" surname
# echo -e "\e[39m The surname is ${surname} \e[0m"

# functions

# f() {
#     echo -e "\e[32m Hai From f() function \e[0m"
#     echo "....................."
#     echo -e "\e[33m Bye from the f() function \e[0m"
# }

# sample() {

#     echo -e "\e[32m Hai From sample() function \e[0m"
#     echo "....................."
#     echo -e "\e[33m Bye from the sample() function \e[0m"

#     f
# }
# sample

#Loops
# <<COMMENT
# ACTION=$1

# case ${ACTION} in
#     start)
#         echo "Start the payment services"
#         ;;
#     stop)
#         echo "Stop the payment services"
#         ;;
#     restart)
#         echo "Restart the payment service"
#         ;;
#     *)
#         echo "Select the proper service"
#         ;;
# esac
#COMMENT

<<COMMENT
if [ $1 == "start" ]; then
    echo -e "\e[32m if Start the payment services \e[0m"
    exit 0
elif [ $1 == "stop" ]; then
    echo -e "\e[32m if Stop the payment services \e[0m"
    exit 1
elif [ $1 == "restart" ]; then
    echo -e "\e[32m if re-Start the payment services \e[0m"
    exit 2
else
    echo -e "\e[32m if Select the proper services \e[0m"
    exit 3
fi
COMMENT

echo "Hai from Comments"

num1=20
num2=30
num3=40

if [[ $num1 -gt $num2 && $num1 -gt $num3 ]]; then
    echo "The ${num1} is greater than ${num2} and ${num3}"
elif [[ $num2 -gt $num1 && $num2 -gt $num3 ]]; then
    echo "The ${num2} is greater than ${num1} and ${num3}"
else
    echo "The ${num3} is greater than ${num1} and ${num2}"
fi

