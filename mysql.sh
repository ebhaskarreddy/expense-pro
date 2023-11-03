log_file=/tmp/expense.log
color="\e[36m"

echo -e "${color} Disable Old Mysql \e[om"
dnf module disable mysql -y &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
  else
    echo -e "\e[33m FAILURE \e[0m"
    fi

echo -e "${color} Copying Mysql Repo File \e[om"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
  else
    echo -e "\e[33m FAILURE \e[0m"
    fi

echo -e "${color} Install Mysql Server \e[om"
dnf install mysql-community-server -y &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
  else
    echo -e "\e[33m FAILURE \e[0m"
    fi

echo -e "${color} Start Mysql Server \e[om"
systemctl enable mysqld  &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
  else
    echo -e "\e[33m FAILURE \e[0m"
    fi


systemctl start mysqld &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
  else
    echo -e "\e[33m FAILURE \e[0m"
    fi


echo -e "${color} Mysql Security With Password \e[om"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m SUCCESS \e[0m"
  else
    echo -e "\e[33m FAILURE \e[0m"
    fi
