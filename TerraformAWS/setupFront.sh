#!/bin/bash

sudo apt update -y
sudo apt install -y nginx git

git clone https://github.com/andervafla/java_deploy.git /var/www/html/java_deploy

sudo cp -r /var/www/html/java_deploy/frontend/build/* /var/www/html/

sudo tee /etc/nginx/sites-available/java_deploy <<EOF
server {
    listen 80;
    server_name localhost;

    location / {
        root /var/www/html;
        index index.html index.htm;
        try_files \$uri \$uri/ /index.html;
    }
}
EOF

sudo ln -s /etc/nginx/sites-available/java_deploy /etc/nginx/sites-enabled/

sudo systemctl restart nginx

echo "Nginx та проект успішно налаштовані!"
