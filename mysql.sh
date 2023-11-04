source common.sh

if [ -z "$1" ]; then
  echo PASSWORD INPUT MISSING
  exit
  fi

echo -e "${color} Disable MySQL Default Version \e[om"
dnf module disable mysql -y &>>log_file
status_check

echo -e "${color} Copying MySQL Repo File \e[om"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>log_file
status_check

echo -e "${color} Install MySQL Server \e[om"
dnf install mysql-community-server -y &>>log_file
status_check

echo -e "${color} Start MySQL Server \e[om"
systemctl enable mysqld  &>>log_file
status_check


systemctl start mysqld &>>log_file
status_check


echo -e "${color} Set MySQL Password \e[om"
mysql_secure_installation --set-root-pass ${MYSQL_ROOT_PASSWORD} &>>log_file
status_check
