#!/bin/bash

# check number of params
if [ $# -ne 1 ];then
  echo "Usage: <jdk_folder>"
  exit 0
fi

# help
if [ $1 == "--help" ];then
  echo "Usage: <jdk_folder>"
  exit 0
fi

# check user is root?
user=`whoami`
if [ $user != "root" ];then
  echo "Please use sudo to run this script"
  exit 0
fi

DEST_PATH="/etc/profile"

echo "make folder jvm in /usr/lib ..."
test -d /usr/lib/jvm && echo "folder already exit" || mkdir /usr/lib/jvm

# check $1 is end of "/"
length1=`expr length $1`
length2=`expr match $1 ".*\/"`
if [ "$length1" == "$length2" ]; then
  jdk=`echo ${1:0:-1}`
else
  jdk=$1
fi

echo "copy java folder to jvm ..."
cp -r $jdk /usr/lib/jvm/

chmod +x /usr/lib/jvm/${jdk}/bin/*

echo "add java path to /etc/profile ..."
cat >> ${DEST_PATH} << EOF
export JAVA_HOME=/usr/lib/jvm/$jdk
export PATH=\$JAVA_HOME/bin:\$PATH
export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
EOF

echo "source profile ..."
source /etc/profile

update-alternatives --install /usr/bin/java java /usr/lib/jvm/$jdk/bin/java 300
update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/$jdk/bin/javac 300

echo "check java version, if it is wrong, please run config_java and config_javac"
echo "***************************************************************"
java -version
echo "***************************************************************"
