#!/bin/bash
apt update && apt upgrade -y
cd /
mkdir docker
cd docker

apt install -y \
 apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    apache2-utils \
    mc 

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt update && apt install docker-ce -y
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
mkdir apps
systemctl start docker
systemctl enable docker
useradd -m -s /bin/bash dockerrun
usermod -a -G docker dockerrun
systemctl restart docker
