log_file=/tmp/expense.log
color="\e[36m"

status_check(){
  if [ $? -eq 0 ]; then
    echo -e "\e[32m SUCCESS \e[0m"
    else
      echo -e "\e[33m FAILURE \e[0m"
      fi
}

echo -e "${color} Installing Nginx \e[om"
dnf install nginx -y &>>log_file
status_check

echo -e "\e[31m Copyinng Expense Confi \e[om"
cp expense.conf /etc/nginx/default.d/expense.conf &>>log_file
status_check

echo -e "\e[33m Cleaning Old Nginx \e[om"
rm -rf /usr/share/nginx/html/* &>>log_file
status_check

echo -e "\e[34m Download Frontend Aplication Code \e[om"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>log_file
status_check

echo -e "\e[35m Extracting Downloaded Aplication Conten \e[om"
cd /usr/share/nginx/html &>>log_file

unzip /tmp/frontend.zip &>>log_file
status_check

echo -e "\e[36m Starting Nginx Service \e[om"
systemctl enable nginx &>>log_file
systemctl restart nginx &>>log_file
status_check






