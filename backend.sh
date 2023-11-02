log_file=/tmp/expense.log
color="\e[36m"

echo -e "${color} Disable Old Nodejs \e[om"
dnf module disable nodejs -y &>>log_file
echo $?

echo -e "${color} Enable Nodejs Version 18 \e[om"
dnf module enable nodejs:18 -y &>log_file
echo $?

echo -e "${color} Installing Nodejs \e[om"
dnf install nodejs -y &>>log_file
echo $?

echo -e "${color} Copying Backend Service \e[om"
cp backend.service /etc/systemd/system/backend.service &>>log_file
echo $?

echo -e "${color} Add User \e[om"
useradd expense &>>log_file
echo $?

echo -e "${color} Creating Directory \e[om"
mkdir /app &>>log_file
echo $?

echo -e "${color} Delete Old Content \e[om"
rm -rf /app* &>>log_file
echo $?

echo -e "${color} Downloading Conten File \e[om"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
echo $?

echo -e "${color} Extracting Downloaded Content \e[om"
unzip /tmp/backend.zip &>>log_file
echo $?

echo -e "${color} Install Nodejs Dependency File \e[om"
npm install
echo $?

echo -e "${color} Install Mysql Schema \e[om"
dnf install mysql -y &>>log_file
mysql -h mysql-dev.rdevops650nline.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>log_file
echo $?

echo -e "${color} Start Backend Server \e[om"
systemctl daemon-reload
systemctl enable backend
systemctl restart backend &>>log_file
echo $?

