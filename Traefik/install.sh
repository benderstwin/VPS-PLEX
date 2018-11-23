#!/bin/bash
read -p "new username: " traefikuser
useradd -m -s /bin/bash $traefikuser
htpasswd -n $traefikuser password > /docker/apps/htpd
su $traefikuser
mkdir -p /docker/apps/traefik/
cd /docker/apps/traefik/
wget https://raw.githubusercontent.com/benderstwin/VPS-PLEX/master/Traefik/traefik.toml
read -p "enter your email: " traefikemail
read -p "what hostname do you want to use like traefik.hostname.fun: " traefikdomainhost
read -p "what domain do you want to use like hostname.fun: " traefikdomain

echo "setting up traefik.toml"
htpd="$(cat /docker/apps/htpwd)"
sed -i "s@passwordhtpwd@${htpd}@" traefik.toml
sed -i "s/[^@ ]*@[^@]*\.[^@ ]*/${traefikemail}/g" traefik.toml
sed -i "s@traefikdomain@${traefikdomainhost}@" traefik.toml
sed -i "s@domainname@${traefikdomain}@" docker-compose.yml
sed -i "s@domainnamehost@${traefikdomainhost}@" docker-compose.yml
touch acme.json
chmod 600 acme.json
docker-compose up -d
