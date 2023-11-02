echo -e "\e[36m Disable Old Nodejs \e[om"

dnf module disable nodejs -y

echo -e "\e[36m Enable Nodejs Version 18 \e[om"
dnf module enable nodejs:18 -y

echo -e "\e[36M Installing Nodejs \e[om"
dnf install nodejs -y

echo -e "\e[36m Copying Backend Service \e[om"
cp backend.service /etc/systemd/system/backend.service

echo -e "\e[36 Add User \e[om"
useradd expense

echo -e "\e[36m Creating Directory \e[om"
mkdir /app

echo -e "\e[36m Downloading Conten File \e[om"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip

echo -e "\e[36m Extracting Downloaded Content \e[om"
cd /app
unzip /tmp/backend.zip

echo -e "\e[36m Creating Directory \e[om"
cd /app

echo -e "\e[36m Install Nodejs Dependency File \e[om"
npm install

echo -e "\e[36m Install Mysql Schema \e[om"
dnf install mysql -y
mysql -h mysql-dev.rdevops650nline.online -uroot -pExpenseApp@1 < /app/schema/backend.sql

echo -e "\e[36m Start Backend Server \e[om"
systemctl daemon-reload
systemctl enable backend
systemctl restart backend

