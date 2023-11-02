log_file=/tmp/expense.log
color="\e[36m"

echo -e "${color} Disable Old Mysql \e[om"
dnf module disable mysql -y &>>log_file
echo $?

echo -e "${color} Copying Mysql Repo File \e[om"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>log_file
echo $?

echo -e "${color} Install Mysql Server \e[om"
dnf install mysql-community-server -y &>>log_file
echo $?

echo -e "${color} Start Mysql Server \e[om"
systemctl enable mysqld  &>>log_file
echo $?

systemctl start mysqld &>>log_file
echo $?

echo -e "${color} Mysql Security With Password \e[om"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>log_file
echo $?