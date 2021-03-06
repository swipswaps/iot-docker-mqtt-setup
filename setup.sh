#!/bin/bash

echo "Setup IoT environment"
echo "Create default folders"

[ -d ./volumes ] || mkdir ./volumes
[ -d ./backups ] || mkdir ./backups


echo "Create subfolders and fix permissions"
for DockerFolder in "./docker"/*/ ; do
    if [ -d ${DockerFolder} ]; then
        echo "$DockerFolder"
        if [ -f $DockerFolder/dirFix.sh ]; then
            chmod +x $DockerFolder/dirFix.sh
            echo "Running dirFix.sh on $DockerFolder"
            bash $DockerFolder/dirFix.sh
	    fi
    fi
done


echo "Update and upgrade sources"
sudo apt update && sudo apt full-upgrade && sudo rpi-update -y ;


echo "Install rclone"
curl https://rclone.org/install.sh | sudo bash
echo "Please run 'rclone config' to configure the rclone google drive backup"

echo "Install Packages (git, build-essential, python3, python3-pi,p gcc, libffi-dev, libssl-dev, python3-dev, samba, samba-common-bin)"
PACKAGES="git build-essential python3 python3-pip gcc libffi-dev libssl-dev python3-dev samba samba-common-bin"
sudo apt install $PACKAGES -qy


echo "Install Docker and Docker-Compose"
if command_exists docker; then
    echo "docker already installed"
else
    echo "Install Docker"
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker $(id -un)
fi

if command_exists docker-compose; then
    echo "docker-compose already installed"
else
    echo "Install docker-compose"
    sudo pip3 install docker-compose
fi


echo "Setup finished"
echo "Run 'docker-compose up -d'"


if (whiptail --title "Restart Required" --yesno "It is recommended that you restart you device now. Select yes to do so now" 20 78); then
    sudo reboot
fi


function command_exists() {
    command -v "$@" >/dev/null 2>&1
}
