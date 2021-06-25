NOR='\033[0m'
BOL='\033[01m'
ITA='\033[3m'
RED='\033[31m'
GRE='\033[32m'
YEL='\033[33m'
BLU='\033[34m'
MAG='\033[35m'
CYA='\033[36m'

echo -ne $YEL$BOL"Can your guest UBUNTU do Copy&Paste with host? "$NOR$BLU"(y/n) : "$CYA$BOL
old_stty_cfg=$(stty -g)
stty raw -echo ; answer=$(head -c 1) ; stty $old_stty_cfg # Careful playing with stty
if echo "$answer" | grep -iq "^y" ;then
	echo -e "[Yes]\n"$NOR
else
	echo -e "[No]\n"$NOR
	echo -e "----------------------------------------------"
	echo -e $YEL$BOL": [APT list \"virtualbox-guest-additions-iso\"]\n"$NOR
	apt list virtualbox-guest-additions-iso
	echo -e $YEL$BOL": [Dont ]\n"$NOR
fi

echo -ne $YEL$BOL"Did you install Chrome? "$NOR$BLU"(y/n) : "$CYA$BOL
old_stty_cfg=$(stty -g)
stty raw -echo ; answer=$(head -c 1) ; stty $old_stty_cfg # Careful playing with stty
if echo "$answer" | grep -iq "^y" ;then
	echo -e "[Yes]\n"$NOR
else
	echo -e "[No]\n"$NOR
	echo -e "----------------------------------------------"
	echo -e $YEL$BOL": [Install Chrome to APT_GET]\n"$NOR
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
	echo -e $YEL$BOL": [APT_GET update]\n"$NOR
	sudo apt-get update
	echo -e $YEL$BOL": [Install Chrome]\n"$NOR
	sudo apt-get install google-chrome-stable
	echo -e $YEL$BOL": [Remove Chrome from APT_GET]\n"$NOR
	sudo rm -rf /etc/apt/sources.list.d/google.list
	echo -e $YEL$BOL": [Complete!]\n"$NOR
fi

echo -ne $YEL$BOL"Did you install Docker? "$NOR$BLU"(y/n) : "$CYA$BOL
old_stty_cfg=$(stty -g)
stty raw -echo ; answer=$(head -c 1) ; stty $old_stty_cfg # Careful playing with stty
if echo "$answer" | grep -iq "^y" ;then
	echo -e "[Yes]\n"$NOR
	echo -e $BOL"Then... maybe complete? LOL"
else
	echo -e "[No]\n"$NOR
	echo -e "----------------------------------------------"
	echo -e $YEL$BOL": [APT_GET update]\n"$NOR
	sudo apt-get update
	echo -e $YEL$BOL": [Install some libraries]\n  [Libraries: \"apt-transport-https\", \"ca-certificates\", \"curl\", \"software-properties-common\"]\n"$NOR
	sudo apt install apt-transport-https ca-certificates curl software-properties-common
	echo -e $YEL$BOL": [Install Docker to APT_GET]"$NOR
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
	echo -e $YEL$BOL": [APT_GET update]\n"$NOR
	sudo apt-get update
	echo -e $YEL$BOL": [Install Docker]\n"$NOR
	apt-cache policy docker-ce
	sudo apt install docker-ce
	echo -e $YEL$BOL": [Install Docker-compose]\n"$NOR
	sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	sudo usermod -aG docker $USER
	echo -e $YEL$BOL": [Complete!]\n\n[Execute \"docker --version\" or \"docker-compose --version\" to check."$NOR
fi