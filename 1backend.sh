log_file=/tmp/expense.log
color="\e[36m"

status_check(){
  if [ $? -eq 0 ]; then
    echo -e "\e[32m SUCCESS \e[0m"
    else
      echo -e "\e[33m FAILURE \e[0m"
      fi
}

echo -e "${color} Disable Nodejs Default Version \e[0m "
dnf module disable nodejs -y &>>log_file
status_check

echo -e "${color} Enable Nodejs 18 Version \e[0m "
dnf module enable nodejs:18 -y &>>log_file
status_check

echo -e "${color} Instal Nodejs \e[0m "
dnf install nodejs -y &>>log_file
status_check

echo -e "${color} Copy Backend Service File \e[0m "
cp backend.service /etc/systemd/system/backend.service &>>log_file
status_check

echo -e "${color} Add Application User \e[0m "
useradd expense &>>log_file
status_check

echo -e "${color} Creat Application Directory \e[0m "
mkdir /app &>>log_file
status_check

echo -e "${color} Delete Old Application Content \e[0m "
rm -rf /app/* &>>log_file
status_check

echo -e "${color} Download Application Content \e[0m "
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
status_check

echo -e "${color} Extract the Application Content \e[0m "
cd /app &>>log_file
unzip /tmp/backend.zip &>>log_file
status_check

echo -e "${color} Download the Nodejs Dependencies \e[0m "
npm install &>>log_file
status_check

systemctl daemon-reload

echo -e "${color} Install Mysql Client to Load schema  \e[0m "
dnf install mysql -y &>>log_file
status_check

echo -e "${color}  Load Schema  \e[0m "
mysql -h mysql-dev.rdevops650nline.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>log_file
status_check

echo -e "${color}  Start Backend service  \e[0m "
systemctl daemon-reload  &>>log_file
systemctl enable backend  &>>log_file
systemctl restart backend  &>>log_file
status_check

