log_file=/tmp/expense.log
color="\e[31m"

echo -e "${color} Installing Nginx \e[om"

dnf install nginx -y &>>log_file

echo -e "\e[31m Copyinng Expense Confi \e[om"
cp expense.conf /etc/nginx/default.d/expense.conf &>>log_file

echo -e "\e[33m Cleaning Old Nginx \e[om"
rm -rf /usr/share/nginx/html/* &>>log_file

echo -e "\e[34m Download Frontend Aplication Code \e[om"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>log_file

echo -e "\e[35m Extracting Downloaded Aplication Conten \e[om"
cd /usr/share/nginx/html &>>log_file
unzip /tmp/frontend.zip &>>log_file

echo -e "\e[36m Starting Nginx Service \e[om"
systemctl enable nginx &>>log_file
systemctl restart nginx &>>log_file






