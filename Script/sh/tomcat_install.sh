#!/bin/bash
sudo amazon-linux-extras enable java-openjdk11
sudo yum install -y java-11-openjdk-devel.x86_64
sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat
sudo mkdir -p /opt/tomcat
wget https://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.65/bin/apache-tomcat-9.0.65.tar.gz -P /tmp
tar xf /tmp/apache-tomcat-9*.tar.gz -C /opt/tomcat
sudo ln -s /opt/tomcat/apache-tomcat-9.0.65 /opt/tomcat/latest
sudo chown -RH tomcat: /opt/tomcat/latest
sudo sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'
sudo cat >> /etc/systemd/system/tomcat.service << EOF
[Unit]
Description=Tomcat 9 servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/jre"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"

Environment="CATALINA_BASE=/opt/tomcat/latest"
Environment="CATALINA_HOME=/opt/tomcat/latest"
Environment="CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=
ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF
sudo sed -i 's/<\/tomcat-users>//' /opt/tomcat/latest/conf/tomcat-users.    xml
sudo echo '\n\
<role rolename="admin-gui"/> \n\
<role rolename="manager-gui"/> \n\
<user username="admin" password="admin_password" roles="admin-gui,manager-gui"/> \n\
<role rolename="manager-script"/> \n\
<role rolename="manager-gui"/> \n\
<role rolename="manager-jmx"/> \n\
<role rolename="manager-status"/> \n\
<user username="tomcat" password="tomcat" roles="manager-gui,manager-script,manager-status,manager-jmx"/> \n\
</tomcat-users> \n\
' >> /opt/tomcat/latest/conf/tomcat-users.xml

sudo sed -i 's/<Valve/<!--<Valve/'  /opt/tomcat/latest/webapps/manager/META-INF/context.xml &&\
sudo sed -i 's/<Manager/--><Manager/'  /opt/tomcat/latest/webapps/manager/META-INF/context.xml &&\
sudo sed -i 's/<Valve/<!--<Valve/'  /opt/tomcat/latest/webapps/host-manager/META-INF/context.xml &&\
sudo sed -i 's/<Manager/--><Manager/'  /opt/tomcat/latest/webapps/host-manager/META-INF/context.xml
sudo cd /opt/tomcat/latest/bin/
sudo systemctl start tomcat
sudo systemctl enable tomcat