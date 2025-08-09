#!/bin/bash
# Description: 
# Author:
# Date Created:
# Version: 
# Date Modified:
num1=200
num2=300
#method1
let sum=num1+num2
echo "The sum of ${num1} and ${num2} is ${sum}"
#method2
diff=$[ num1 - num2 ]
echo "The diff of ${num1} and ${num2} is ${diff}"
#method3
product=$((num1 * num2))
echo "The product of ${num1} and ${num2} is ${product}"
result=$(expr $num1 / $num2)
echo "The product of ${num1} and ${num2} is ${result}"