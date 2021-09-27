#!/bin/bash

# Variables Start

# OS Name
os=$(lsb_release -i | cut -f 2-)
# Username
username=$(id -u -n)
# PWD
path=${PWD}

# svn credentials
uname=aquib.ahmed
pwd=Aahlaad!23

# Variables End

# List of repositories
repositories="\
deb http://deb.debian.org/debian bullseye main contrib non-free
deb-src http://deb.debian.org/debian bullseye main contrib non-free

deb http://deb.debian.org/debian-security/ bullseye-security main contrib non-free
deb-src http://deb.debian.org/debian-security/ bullseye-security main contrib non-free

deb http://deb.debian.org/debian bullseye-updates main contrib non-free
deb-src http://deb.debian.org/debian bullseye-updates main contrib non-free

deb http://deb.debian.org/debian bullseye-backports main contrib non-free
deb-src http://deb.debian.org/debian bullseye-backports main contrib non-free
"

# cleans sources file and inserts values from repositories
sudo truncate -s0 /etc/apt/sources.list &&
echo "$repositories" > /etc/apt/sources.list

# updates and cleans the OS
sudo apt-get -y update &&
sudo apt-get -y upgrade &&
sudo apt-get -y dist-upgrade &&
sudo apt-get -y full-upgrade &&
sudo apt-get -y install --fix-missing --fix-broken &&
sudo apt-get -y clean &&
sudo apt-get -y autoremove

# Sets the current time and timezone
sudo timedatectl set-timezone Asia/Kolkata

# Removes the typing of username at start-up
sudo bash -c 'echo "[SeatDefaults]" >> /usr/share/lightdm/lightdm.conf.d/01_my.conf' &&
sudo bash -c 'echo "greeter-hide-users=false" >> /usr/share/lightdm/lightdm.conf.d/01_my.conf'

# Theming Terminator
cat terminatorUI.txt >> ~/.bashrc

# Copying file sharing config file and restarting the daemon
cp -avrf vsftpd.conf /etc/ &&
sudo service vsftpd restart

# Removing bloatwares
sudo apt-get -y purge --auto-remove empathy brasero sound-juicer totem pidgin firefox-esr gimp imagemagick-* hexchat firefox thunderbird chromium remmina #synaptic*

rm -rf ~/.mozilla
rm -rf ~/.config/chromium
rm -rf ~/.cache/chromium
sudo rm -rf /etc/chromium

# Removing games
sudo apt-get -y purge --auto-remove gnome-2048 aisleriot atomix gnome-chess five-or-more hitori iagno gnome-klotski lightsoff gnome-mahjongg gnome-mines gnome-nibbles quadrapassel four-in-a-row gnome-robots gnome-sudoku swell-foop tali gnome-taquin gnome-tetravex

# Downloads

# Essentials
# sudo apt-get -y install firmware-realtek
# sudo apt-get -y install firmware-linux-nonfree
# sudo apt-get -y install software-properties-common apt-transport-https wget

# Installing Chrome
# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# sudo apt install -y ./google-chrome-stable_current_amd64.deb

# Installing VS-Code
# wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
# sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
# sudo apt-get -y update
# sudo apt-get install -y code

mkdir -p test
cd test
# svn checkout --username $uname --password $pwd https://dev.aahlaad.com:8443/svn/SaarathyGUI/

cd test/SaarathyGUI

echo "success"