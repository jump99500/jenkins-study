## shell script 작성
[cmd] scp -i <pem file> -r .aws ubuntu@<IP>:/home/ubuntu/ # 해당 경로에 key 파일, .aws설정폴더 두기

## eks_install.sh

#!/bin/bash
sudo apt-get install -y unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.23.7/2022-06-29/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
eksctl create cluster --name eks-test --region ap-northeast-2 --with-oidc --ssh-access --ssh-public-key aws_k8s_test --nodes 2 --node-type t3.small --node-volume-size=8 --managed --nodes-min 2 --nodes-max 3

# 수동으로 쉘에서 입력
$ export PATH=$PATH:$HOME/bin && source <(kubectl completion bash) && echo "source <(kubectl completion bash)" >> ~/.bashrc