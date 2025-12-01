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

read -p "Welcome to Villa:" villa_name
echo -e "\e[32m The villa name is ${villa_name} \e[0m"