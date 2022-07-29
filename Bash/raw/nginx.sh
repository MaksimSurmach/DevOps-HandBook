#!/bin/bash
#Color Varible
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
CONFIG = $(cat <<-EOF
server {
        listen 8080 default_server;
        listen [::]:8080 default_server;

        root /var/www/html;

        index index.html ;

        server_name msurmach;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files $uri $uri/ =404;
        }
   
}
EOF
)
JSN=$(cat <<-EOF
    {
    "name": "msurmach",
    "os": "Ubuntu 20.04.3 LTS",
    "ip": "10.6.221.170",
    "cpu": "1",
    "memory": "1.6Gi"
    }
EOF
)


apt install nginx -y

cat $CONFIG > /etc/nginx/sites-available/default
cat $JSON > /var/www/html/index.html

service nginx restart


#CRON
#cp /etc/nginx/nginx.conf /etc/nginx/conf.d/nginx-`date +%s`.conf.bak
echo "*/10 * * * 4-6  sudo cp /etc/nginx/nginx.conf /etc/nginx/conf.d/nginx-$(date +'\%s').conf.bak" >> /var/spool/cron/crontabs/msurmach
# */10 * * * 4-6 /etc/nginx/nginx.conf > /etc/nginx/conf.d/nginx-${date +%s}.conf.bak
#*/1 * * * * /etc/nginx/nginx.conf > /etc/nginx/conf.d/nginx-${date +%s}.conf.bak

#logrotate
#sudo vim /etc/logrotate.d/nginx
#change daily to weekly

#immutable
 echo "hello" > /immutable.txt
 chmod 777 /immutable.txt
 chown msurmach:cdrom /immutable.txt

#bashAlias
echo alias eip=\"curl ifconfig.me\" >> ~/.bashrc


#STATIC ROUTE
sudo ip route add ECSC00A0CDE5.epam.com via ECSC00A0CDE4.epam.com

я в yaml дописал routes:
             - to: 10.6.218.187/32
               via: 10.6.218.189
               metric: 100
/etc/network/50-cloud-init.yaml