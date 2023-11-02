echo -e "\e[32m Installing Nginx \e[om"

dnf install nginx -y

echo -e "\e[36m Copeing Expense Confi \e[om"
cp expense.conf /etc/nginx/default.d/expense.conf

echo -e "\e[36m Cleaning Old Nginx \e[om"
rm -rf /usr/share/nginx/html/*

echo -e "\e[36m Download Frontend Aplication Code \e[om"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[36m Extracting Downloaded Aplication Conten \e[om"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[34m Starting Nginx Service \e[om"
systemctl enable nginx
systemctl restart nginx






