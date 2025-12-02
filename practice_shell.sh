<<COMMENT
echo "Welcome to Shell Scripting"
echo -e "Welcome to \n shell scripting \t Guru"
echo -e "\e[32m This is Guru Theja \e[0m"


a=10
b=10
c=xyz

echo -e "\e[32m The value of a is ${a} \e[0m"
echo -e "\e[34m The value of b is ${b} \e[0m"
echo -e "\e[35m The value of c is ${c} \e[0m"
echo -e "\e[36m The value of d is ${d} \e[0m"

#Dynamic Variables

date="$(date +%D)"
dir="$(pwd)"
session_count="$(who|wc -l)"

echo -e "\e[32m today date is ${date} \e[0m"
echo -e "\e[33m current dire is ${dir} \e[0m"
echo -e "\e[34m the current session count is ${session_count} \e[0m"

echo $0
echo $?
echo "ur name is $1"
echo "ur age is $2"

echo "The argument details are $@"
echo "The no.of arguments are $#"
echo "The PID is $$"

# read -p "Welcome to Villa:" villa_name
# echo -e "\e[32m The villa name is ${villa_name} \e[0m"

f() {
    echo "Hello from f() function"
    echo "......................"
    echo "Bye from f() function"
}



sample() {
    echo "Hello from sample() function"
    echo "................"
    echo "Bye from sample() function"
    f
}

sample 

# ACTION=$1

# case ${ACTION} in
#     start)
#         echo "The payment services started"
#         ;;
#     stop)
#         echo "The payment services stopped"
#         ;;
#     restart)
#         echo "The payment services re-started"
#         ;;
#     *)
#         echo "Please select the correct"
#         ;;
# esac 

ACTION=$1

if [ "${ACTION}" == "start" ]; then

    echo -e "\e[32m The payment services started \e[0m"
    exit 0

elif [ "${ACTION}" == "stop" ]; then

    echo -e "\e[33m The payment services stopped \e[0m"
    exit 1

elif [ "${ACTION}" == "restart" ]; then

    echo -e "\e[34m The payment services restarted \e[0m"
    exit 2
else

    echo -e "\e[35m Select the correct answer \e[0m"
    exit 3
fi 
COMMENT

# a=10
# b=20
# c=30

# if ([ ${a} -eq 10 ] ||  [ ${b} -eq 30 ]) && [ ${c} -eq 30 ]; then
#     echo "All two comdition OK"
# else
#     echo "At least one condition failed"
# fi

# if [ ! ${a} -eq 10 ]; then
#     echo "The value of a is ${a}"
# else
#     echo "The value of a is ${a} ............"
# fi

VAR="$(cat practice_shell.sh)"

if [ -n "${VAR}" ]; then
    echo "The file has content"
else
    echo "The file has no content"
fi


