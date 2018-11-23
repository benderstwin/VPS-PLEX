read -p "new username: " traefikuser
read -p "new password: " traefikpass
useradd -m -s /bin/bash $traefikuser
su $traefikuser
mkdir -p /docker/apps/traefik/
cd /docker/apps/traefik/
wget traefik.toml
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
echo "your username and password for traefik are stored in a file at /docker/apps"
touch acme.json
chmod 600 acme.json
docker-compose up -d
