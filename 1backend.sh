source common.sh

if [ -z "$1" ]; then
  echo PASSWORD INPUT MISSING
  exit
  fi

MYSQL_ROOT_PASSWORD=$1

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

systemctl daemon-reload

# i got error here exit status 9 .it means user name already use , it can handle by
id expense &>>log_file
if [ $? -ne 0 ]; then
  echo -e "${color} Add Application User \e[0m "
  useradd expense &>>log_file
  status_check
fi

# here i get error as exit status 1 . means cant update passwrd file
if [ ! -d /app ]; then
echo -e "${color} Creat Application Directory \e[0m "
  mkdir /app &>>log_file
  status_check
fi
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

echo -e "${color} Install Mysql Client to Load schema  \e[0m "
dnf install mysql -y &>>log_file
status_check

#got exitstatus 1. cant update password file
echo -e "${color}  Load Schema  \e[0m " # HERE PASSWOORD HARDCODED
mysql -h mysql-dev.rdevops650nline.online -uroot -p${MYSQL_ROOT_PASSWORD} < /app/schema/backend.sql &>>log_file
echo $?

echo -e "${color}  Start Backend service  \e[0m "
systemctl daemon-reload  &>>log_file
systemctl enable backend  &>>log_file
systemctl restart backend  &>>log_file
status_check

