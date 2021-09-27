#!/bin/bash

# ! Variables Start

# OS Name
os=$(lsb_release -i | cut -f 2-)
# Username
username=$(id -u -n)
# PWD
path=${PWD}

# svn credentials
uname=aquib.ahmed
pwd=Aahlaad!23

# ! Variables End

# ! List of repositories
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

# ! Cleans sources file and inserts values from repositories
sudo truncate -s0 /etc/apt/sources.list &&
echo "$repositories" > /etc/apt/sources.list

# ! Updates and cleans the OS
sudo apt-get -y update &&
sudo apt-get -y upgrade &&
sudo apt-get -y dist-upgrade &&
sudo apt-get -y full-upgrade &&
sudo apt-get -y install --fix-missing --fix-broken &&
sudo apt-get -y clean &&
sudo apt-get -y autoremove

# ! Preparing Folders
mkdir -p ~/Installation &&
mkdir -p ~/Documents/Aahlaad &&
cd ~/Installation

# ! Sets the current time and timezone
sudo timedatectl set-timezone Asia/Kolkata

# ! Removes the typing of username at start-up
sudo bash -c 'echo "[SeatDefaults]" >> /usr/share/lightdm/lightdm.conf.d/01_my.conf' &&
sudo bash -c 'echo "greeter-hide-users=false" >> /usr/share/lightdm/lightdm.conf.d/01_my.conf'

# ! Theming Terminator
cat terminatorUI.txt >> ~/.bashrc

# ! Copying file sharing config file and restarting the daemon
cp -avrf vsftpd.conf /etc/ &&
sudo service vsftpd restart

# ! Removing bloatwares
sudo apt-get -y purge --auto-remove empathy brasero sound-juicer totem pidgin firefox-esr gimp imagemagick-* hexchat firefox thunderbird chromium remmina #synaptic*

rm -rf ~/.mozilla
rm -rf ~/.config/chromium
rm -rf ~/.cache/chromium
sudo rm -rf /etc/chromium

# !Removing games
sudo apt-get -y purge --auto-remove gnome-2048 aisleriot atomix gnome-chess five-or-more hitori iagno gnome-klotski lightsoff gnome-mahjongg gnome-mines gnome-nibbles quadrapassel four-in-a-row gnome-robots gnome-sudoku swell-foop tali gnome-taquin gnome-tetravex

# ! Downloads Starts

# ! Essentials
sudo apt-get -y install firmware-realtek
sudo apt-get -y install firmware-linux-nonfree
sudo apt-get -y install software-properties-common apt-transport-https wget

# Installing Chrome
# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# sudo apt install -y ./google-chrome-stable_current_amd64.deb

# Installing VS-Code
# wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
# sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
# sudo apt-get -y update
# sudo apt-get install -y code

# Installing required softwares
sudo apt-get install -y vlc
sudo apt-get install -y gufw
sudo apt-get install -y default-jdk
sudo apt-get install -y sqlitebrowser
sudo apt-get install -y terminator
sudo apt-get install -y unzip
sudo apt-get install -y curl
sudo apt-get install -y subversion
sudo apt-get install -y rabbitvcs-nautilus
sudo apt-get install -y adb
sudo apt-get install -y nautilus
sudo apt-get install -y build-essential
sudo apt-get install -y protobuf-compiler
sudo apt-get install -y intel-microcode
sudo apt-get install -y fonts-powerline
sudo apt-get install -y vsftpd
sudo apt-get install -y numlockx

# CPU manager
sudo apt-get install -y flatpak
sudo apt-get install -y gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# After reboot
# sudo reboot
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user install flathub com.leinardi.gst
# run app
# flatpak run com.leinardi.gst

sudo apt-get -y install ttf-mscorefonts-installer rar unrar libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi

# Installing Wine
sudo apt-get install -y wine &&
sudo dpkg --add-architecture i386 &&
sudo apt-get update &&
sudo apt-get install wine32 -y  &&
sudo ln -s /usr/share/doc/wine/examples/wine.desktop /usr/share/applications/ &&
sudo apt install -y winetricks &&
# Configuring Wine
winecfg

# Preparing Install for Saarathy
sudo apt-get install -y nodejs npm
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
sudo npm install -g typescript@3.9.5 browserify ts-protoc-gen

# use below line if if you don't have protobuf file
curl -OL https://github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-linux-x86_64.zip &&
unzip -o protoc-3.3.0-linux-x86_64.zip -d protoc3 &&
sudo rm -rf /usr/local/include/* &&
sudo mv --force protoc3/bin/* /usr/local/bin/ &&
sudo mv --force protoc3/include/* /usr/local/include/ &&
sudo chown $username /usr/local/bin/protoc &&
sudo chown -R $username /usr/local/include/google

# ! Preparing SaarathyGUI
# svn checkout --username $uname --password $pwd https://dev.aahlaad.com:8443/svn/SaarathyGUI/
# cd ~/Documents/Aahlaad/SaarathyGUI
# svn export https://github.com/aquibahmed21/LinuxFreshInstallationScript/trunk/res/lib
# cd ~/Documents/Aahlaad/SaarathyGUI/.vscode
# cat >tasks.json <<EOL
# {
# 	// See https://go.microsoft.com/fwlink/?LinkId=733558
# 	// for the documentation about the tasks.json format
# 	"version": "2.0.0",
# 	"tasks":
# 	[
# 		{
# 			"label": "Run SaarathyClient",
# 			"command": "./build.sh",
# 			"group":
# 			{
# 				"kind": "build",
# 				"isDefault": true
# 			}
# 		}
# 	]
# }
# EOL