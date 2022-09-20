#!/bin/bash
sudo su
sudo mkdir -p /home/ec2-user/docker
suod cat >> /home/ec2-user/docker/jenkins.yaml <<-ENQ
version: '3'

services:
    jenkins:
        image: jenkins/jenkins:lts
        container_name: jenkins_cicd
        volumes:
            - /var/run/docker.sock:/var/run/docker.sock
            - /jenkins:/var/jenkins_home
        ports:
            - "8080:8080"
        privileged: true
        user: root
ENQ

sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` | sudo tee /usr/local/bin/docker-compose > /dev/null
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

sudo cd /home/ec2-user/docker/
sudo docker-compose up -d   