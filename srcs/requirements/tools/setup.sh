RED='\033[31m'
GRE='\033[32m'
ORA='\033[33m'
BLU='\033[34m'
MAG='\033[35m'
CYA='\033[36m'
WHI='\033[37m'
BOl='\033[1m'
NOR='\033[0m'

if [ ! -d /home/kkim ]
then
	echo "There is no folder /home/kkim."
	echo "Please change file settings as yours. (setup.sh and docker-compose.yml)"
	exit
fi
sudo echo "127.0.0.1 kkim.42.fr" >> /etc/hosts
sudo echo "127.0.0.1 www.kkim.42.fr" >> /etc/hosts
echo -ne $YEL$BOL"Do you want to remove previous data and boot? "$NOR$BLU"(y/n) : "$CYA$BOL
old_stty_cfg=$(stty -g)
stty raw -echo ; answer=$(head -c 1) ; stty $old_stty_cfg
if echo "$answer" | grep -iq "^y" ;then
	echo -e "[Yes]\n"$NOR
	echo -e "----------------------------------------------"
	echo -e $YEL$BOL"[Removing `/home/kkim/data` folder's Contents]"$NOR
	sudo rm -rf /home/kkim/data/wp
	sudo rm -rf /home/kkim/data/db
	echo -e $YEL$BOL"[Remaking data folders]"$NOR
	sudo mkdir /home/kkim/data/wp
	sudo mkdir /home/kkim/data/db
	echo -e $YEL$BOL"[make down]"$NOR
	make down
	echo -e $YEL$BOL"[docker system prune]"$NOR
	docker system prune
	echo -e $YEL$BOL"[Removing volumes]"$NOR
	docker volume rm srcs_db_vol
	docker volume rm srcs_wp_vol
else
	echo -e "[No]\n"$NOR
fi