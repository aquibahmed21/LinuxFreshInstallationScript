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
