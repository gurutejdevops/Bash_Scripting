#!/bin/bash
<<COMMENT
ACTION=$1

case $ACTION in
    start)
        echo -e "\e[32m Payments services started \e[0m"
        exit 0
        ;;
    stop)
        echo -e "\e[34m Payment services stopped \e[0m"
        exit 1
        ;;
    restart)
        echo -e "\e[35m Payments services resarted \e[0m"
        exit 2
        ;;
    *)
        echo "Valid options are start or stop or restart"
        echo -e "Ex \n\t scriptname.sh stop"
        exit 3
        ;;
esac
COMMENT

<<COMMENT

if [ expression ]; then
      
      commands
fi

if [ expression ]; then

    command 1
else
    command 2
fi

if [ expression ]; then

    command1

elif [ expression ]; then
    
    command2

elif [ expression ]; then

    command 3
else 

    command 4
fi

COMMENT