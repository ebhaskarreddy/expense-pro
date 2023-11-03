log_file=/tmp/expense.log
color="\e[36m"

status_check(){
  if [ $? -eq 0 ]; then
    echo -e "\e[32m SUCCESS \e[0m"
    else
      echo -e "\e[33m FAILURE \e[0m"
      fi

}

echo -e "${color} Disable Old Nodejs \e[om"
dnf module disable nodejs -y &>>log_file
status_check

echo -e "${color} Enable Nodejs Version 18 \e[om"
dnf module enable nodejs:18 -y &>log_file
status_check

echo -e "${color} Installing Nodejs \e[om"
dnf install nodejs -y &>>log_file
status_check

echo -e "${color} Copying Backend Service \e[om"
cp backend.service /etc/systemd/system/backend.service &>>log_file
status_check


id expense &>>log_file
if [ $? -ne 0 ]; then
  echo -e "${color} Addapplication User \e[om"
useradd expense &>>log_file
  status_check
    fi

if [ ! -d /app ]; then
  echo -e "${color} Creating Appliction Directory \e[om"
  mkdir /app &>>log_file
  status_check
    fi

echo -e "${color} Delete Old Application Content \e[om"
rm -rf /app* &>>log_file
status_check

echo -e "${color} Downloading Conten File \e[om"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
status_check

echo -e "${color} Extracting Downloaded Content \e[om"
unzip /tmp/backend.zip &>>log_file
status_check

echo -e "${color} Install Nodejs Dependency File \e[om"
npm install
status_check

echo -e "${color} Install Mysql Schema \e[om"
dnf install mysql -y &>>log_file
mysql -h mysql-dev.rdevops650nline.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>log_file
status_check

echo -e "${color} Start Backend Server \e[om"
systemctl daemon-reload
systemctl enable backend
systemctl restart backend &>>log_file
status_check

