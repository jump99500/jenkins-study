#!/bin/bash
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sudo sh -c 'cat >> /etc/httpd/conf/httpd.conf << EOF
<VirtualHost *:80>
ProxyRequests Off
ProxyPreserveHost On

<Proxy *>
Order deny,allow
Allow from all
</proxy>

ProxyPass / http://172.31.196.142:8080/
ProxyPassReverse / http://172.31.196.142:8080/
</VirtualHost>
EOF'

sudo systemctl restart httpd
sudo systemctl enable httpd