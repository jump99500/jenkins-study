#!/bin/bash
sudo amazon-linux-extras install java-openjdk11 -y
sudo groupadd --system tomcat
sudo useradd -d /usr/share/tomcat -r -s /bin/false -g tomcat tomcat
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.56/bin/apache-tomcat-9.0.56.tar.gz
cp ~/.bash_profile ~/.bash_profile_old
echo "export FIDOBASE_HOME=/home/fido/MagicFIDO" >> ~/.bash_profile
source ~/.bash_profile
cd "${FIDOBASE_HOME}"
tar -xvf apache-tomcat-9.0.56.tar.gz
mv apache-tomcat-9.0.56 tomcat9
echo "export CATALINA_HOME=/home/fido/MagicFIDO/tomcat9" >> ~/.bash_profile
echo "export PATH=$PATH:${CATALINA_HOME}/bin" >> ~/.bash_profile
echo "PS1=${PS1}"
source ~/.bash_profile
cd "${CATALINA_HOME}"/bin; ./startup.sh
cd "${CATALINA_HOME}"/logs; tail -f catalina.out