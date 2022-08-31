#!/bin/bash
sudo -i
amazon-linux-extras enable java-openjdk11
yum install -y java-11-openjdk-devel.x86_64
cat >> /etc/profile <<-ENQ
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.12.0.7-0.amzn2.0.2.x86_64
export PATH=$PATH:$JAVA_HOME/bin
ENQ

sudo yum install -y git
source /etc/profile
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
amazon-linux-extras enable epel
yum install epel-release -y
yum install -y jenkins
sed -i 's/JENKINS_PORT="8080"/JENKINS_PORT="60010"/g' /etc/sysconfig/jenkins
sed -i 's/"JENKINS_PORT=8080"/JENKINS_PORT="60010"/g' /usr/lib/systemd/system/jenkins.service
systemctl start jenkins
systemctl enable jenkins
sudo cat  >> /etc/sudoers<<-ENS
jenkins         ALL=(ALL)       NOPASSWD: ALL
ENS

sudo systemctl daemon-reload
sudo systemctl restart jenkins.service