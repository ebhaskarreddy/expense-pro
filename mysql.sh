
echo -e "\e[36 Disable Old Mysql \e[om"
dnf module disable mysql -y &>>/tmp/expense.log

echo -e "\e[36m Copying Mysql Repo File \e[om"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/expense.log

echo -e "\e[36m Install Mysql Server \e[om"
dnf install mysql-community-server -y &>>/tmp/expense.log

echo -e "\e[36m Start Mysql Server \e[om"
systemctl enable mysqld  &>>/tmp/expense.log
systemctl start mysqld &>>/tmp/expense.log

echo -e "\e[36m Mysql Security With Password \e[om"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>/tmp/expense.log