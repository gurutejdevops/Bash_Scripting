#!/bin/bash

ACTION=$1

case ${ACTION} in
    start)
        echo "Start the payment service"
    stop)
        echo "stop the payment service"
    restart)
        echo "restart the payment service"
    *)
        echo "Please select correct option start, stop or restart"
esac