#!/bin/bash
arch=$(uname -m)
kernel=$(uname -r)
if [ -f /etc/lsb-release ]; then
        os=$(lsb_release -s -d)
elif [ -f /etc/debian_version ]; then
        os="Debian $(cat /etc/debian_version)"
elif [ -f /etc/redhat-release ]; then
        os=`cat /etc/redhat-release`
elif [ -f /etc/os-release ]; then
        os=`cat /etc/os-release`
else
        os="$(uname -s) $(uname -r)"
fi

if [[ $os == *"Debian"* ]]
then
  os_name="Debian";
fi

if [[ $os == *"CentOS"* ]]
then
  os_name="CentOS";
fi

if [[ $os == *"Ubuntu"* ]]
then
   os_name="Ubuntu";
fi

if [[ $os == *"Fedora"* ]]
then
   os_name="Fedora";
fi

if [[ $os == *"Red Hat"* ]]
then
   os_name="Redhat";
fi

if [[ $os == *"openSUSE"* ]]
then
   os_name="openSUSE";
fi

if [[ $os == *"Linux Mint"* ]]
then
   os_name="LinuxMint";
fi


echo "arch:"${arch} 
echo "kernel:"${kernel} 
echo "os:"${os} 
echo "os_name:"${os_name} 


#test_java=$(which ls)

test_java=$(which java)

echo "java path:"${test_java}

if [[ $test_java == "" ]]
then
  echo "No Java !"
else
  java_output=`java -version 2>&1`
  echo "java_output:" ${java_output}

  if [[ $java_output == *"OpenJDK"* ]]
  then
    java_type="OpenJDK";
  fi

  if [[ $java_output == *"Java(TM)"* ]]
  then
    java_type="Oracle";
  fi

  java_version=$(java -version 2>&1 | sed 's/java version "\(.*\)\.\(.*\)\..*"/\1\2/; 1q')
fi

echo "java_type:" ${java_type}
echo  "java_version:"${java_version}

if [[ ${os_name} == "openSUSE" ]]; then  #Both OpenJDK and Oracle can work, need to show widget.
    show_widget=1
elif [[ ${os_name} == "Redhat" ]]; then  #Both OpenJDK and Oracle can work, default show status icon.
    show_widget=0
elif [[ ${os_name} == "Debian" ]]; then  #Both OpenJDK and Oracle can work, need to show widget.
    show_widget=1
elif [[ ${os_name} == "Ubuntu" ]] && [[ ${java_type} == "OpenJDK" ]]; then #WSClient freeze with some OpenJDK version, show widget can work fine.
    show_widget=1
elif [[ ${os_name} == "Fedora" ]] && [[ ${java_type} == "Oracle" ]]; then #Work well in Oracle, need show widget.
    show_widget=1
elif [[ ${os_name} == "Fedora" ]] && [[ ${java_type} == "OpenJDK" ]]; then  #WSClient can't be launched with OpenJDK, so need to prompt user to install Oracle.
    show_widget=1
elif [[ ${os_name} == "LinuxMint" ]]; then 
    show_widget=0
else 
    show_widget=0
fi

# make sure that the script have the correct permission to execute
chmod +x p.sh
chmod +x capture_ext.sh 

# create "timetracker" directory under home directory
if [ -d ~/timetracker ]; then
  echo "timetracker directory exists"
else 
  # Control will enter here if $DIRECTORY exists.
  mkdir ~/timetracker
fi

# check whether gnome-screenshot needs to be installed in the case of wayland display server
need_install_gnome_screenshot=0
if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
  # write the display type to a file so that Java program can read it
  echo "$XDG_SESSION_TYPE" > ~/timetracker/display_type.txt
  echo "Checking gnome-screenshot command ... "
	if type "gnome-screenshot" &> /dev/null; then
		    echo "gnome-screenshot command found"
	else 
		  need_install_gnome_screenshot=1
		  echo "gnone-screenshot command NOT found"
	fi
fi

if [ ${need_install_gnome_screenshot} -eq 1 ]; then 
  echo "IMPORTANT: You need to install gnome-screenshot. "
  echo "Please use this instruction -- http://worksnaps.freshdesk.com/support/solutions/articles/4000111373-how-to-install-gnome-screenshot-on-linux-if-you-get-black-screen-shots-"
  exit 0
fi

if [ ${show_widget} -eq 0 ]; then 
	java -Djava.library.path="./lib" -jar "./WSClient.jar"
fi

if [ ${show_widget} -eq 1 ]; then 
	java -Djava.library.path="./lib" -Dshowwidget="1" -jar "./WSClient.jar"
fi

if [ ${show_widget} -eq 2 ]; then 
	echo "The WSClient can't work well with OpenJDK, please install Oracle Java and try again or contact Worksnaps support team. Thanks!"
	echo "You need to have Oracle Java installed for Worksnaps Client to work. Please install Oracle Java on your system following this instruction -- http://worksnaps.freshdesk.com/solution/articles/4000083082-how-to-install-oracle-java-on-fedora"
fi

