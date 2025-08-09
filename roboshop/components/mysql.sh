#!/bin/bash

COMPONENT=mysql
LOGFILE=/tmp/${COMPONENT}.log
USER_ID="$(id -u)"

if [ ${USER_ID} -ne 0 ]; then
    echo -e "\e[31m script is expected to execute by the root user or with a sudo privilege \e[0m 
    \n \t Example: \n\t sudo wrapper.sh ${COMPONENT}.sh"
    exit 1
fi

stat() {
    if [ $1 -eq 0 ]; then
         echo -e "\e[32m success \e[0m"
    else
         echo -e "\e[31m Failure \e[0m"
         exit 2
    fi
}

<<COMMENT
echo -e -n "\e[32m Configuration ${COMPONENT}...........! \e[0m "
sudo yum remove mysql-community-client-plugins mysql-community-common mysql-community-server -y &>> ${LOGFILE}
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo &>> ${LOGFILE}
stat $?

echo -e -n "\e[32m Installing ${COMPONENT}...........! \e[0m "
yum install mysql-community-server -y  &>> ${LOGFILE}
stat $?

echo "🔹 Checking and fixing CentOS 7 repo..."
if grep -q "vault.centos.org" /etc/yum.repos.d/CentOS-Base.repo; then
    echo "CentOS repo already points to vault.centos.org. Skipping..."
else
    sudo sed -i 's|mirrorlist=http://mirrorlist.centos.org|#mirrorlist=http://mirrorlist.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo &>> ${LOGFILE}
    sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo &>> ${LOGFILE}
    echo "CentOS repo updated to vault.centos.org."
fi

echo "Cleaning YUM cache..."
sudo yum clean all  &>> ${LOGFILE}
sudo yum makecache  &>> ${LOGFILE}

MYSQL_REPO_FILE="/etc/yum.repos.d/mysql57.repo" 

echo "Checking if MySQL 5.7 repo already exists..."
if [ -f "$MYSQL_REPO_FILE" ]; then
    echo "MySQL repo already exists. Skipping..."
else
    echo "🔹 Adding MySQL 5.7 repository..."
    sudo tee "$MYSQL_REPO_FILE" <<EOF
[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=https://repo.mysql.com/yum/mysql-5.7-community/el/7/x86_64/
enabled=1
gpgcheck=0
EOF
fi

echo "Checking if MySQL is already installed..."
if rpm -q mysql-community-server >/dev/null 2>&1; then
    echo "MySQL 5.7 is already installed. Skipping installation..."
else
    echo "Installing MySQL 5.7..."
    sudo yum install mysql-community-server -y  &>> ${LOGFILE}
fi

echo "Ensuring MySQL service is enabled and started..."
sudo systemctl enable mysqld  &>> ${LOGFILE}
sudo systemctl start mysqld   &>> ${LOGFILE}



# Show temporary password if first installation
if [ -f /var/log/mysqld.log ] && grep -q "temporary password" /var/log/mysqld.log; then
    TEMP_PASS=$(grep "temporary password" /var/log/mysqld.log | awk '{print $NF}' | tail -n 1)
    echo "MySQL temporary root password: $TEMP_PASS"
fi

echo "mySQL 5.7 installation process completed!"
COMMENT

echo -n "Extracting the Default ${COMPONENT} password:"
DEFAULT_ROOT_PASSWORD=$(sudo grep 'temporary password' /var/log/mysqld.log | cut -d ' ' -f11)
echo "The Default password is: ${DEFAULT_ROOT_PASSWORD}"
stat $?

echo -n "Default ${COMPONENT} password reset:"
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1'" | mysql --connect-expired-password -uroot -p${DEFAULT_ROOT_PASSWORD} &>> ${LOGFILE}
stat $?



