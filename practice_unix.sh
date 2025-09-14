#!/bin/bash
# echo "Hello World"
# a=10
# b=20
# c=xyz
# echo -e "\e[33m The value of a is: ${a} \e[0m"
# echo -e "\e[32m The value of b is: ${b} \e[0m"
# echo -e "\e[43;32m The value of c is: ${c} \e[0m"
# echo -e "\e[32m The value of x is: ${x} \e[0m"
# date="$(date +%D)"
# session_count="$(who | wc -l)"
# dir="$(pwd)"
# echo -e "\e[32m The date is ${date} \e[0m"
# echo -e "\e[32m The session_count is ${session_count} \e[0m"
# echo -e "\e[33m The dir is ${dir} \e[0m"

# echo -e "\e[32m The value of first argument is $1 \e[0m"
# echo -e "\e[32m the value of second argument is $2 \e[0m"
# echo -e "\e[32m The script name is $0 \e[0m"
# echo "The arguments are $*"
# echo "The PID value is $$"
# echo "The no.of arguments $#"
# echo "The result of last execution command is $?"

# # read -p "Enter the name:" name
# # echo -e "\e[32m The name is ${name} \e[0m"

# f() {

#     echo "the below message from function f"
#     echo "Welcome to f function universe"
# }

# f

# case $3 in
#     start)
#         echo "The payment service is started"
#         ;;
#     stop)
#         echo "The payment service is stopped"
#         ;;
#     restart)
#         echo "The payment service is re-started"
#         ;;
#     *)
#         echo "Please select correct option start, stop or restart"
#         ;;
# esac

# a=10
# b=20
# c=30

# if [ $a -eq 10 ] && ([ $b -eq 20 ] || [ $c -eq 30 ])
# then
#     echo -e "\e[32m one conditions were stastified \e[0m"
# else
#     echo -e "\e[32m The conditions were not stastified \e[0m"
# fi

a=teja

if [ "$a" == "guru" ]
then
   echo "condition is not satisfied"
fi
