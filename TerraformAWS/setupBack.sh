#!/bin/bash
sudo apt update
sudo apt install openjdk-11-jdk -y

cd /tmp
curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.95/bin/apache-tomcat-9.0.95.tar.gz


sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-9.0.95.tar.gz -C /opt/tomcat --strip-components=1


sudo chown -R $USER:$USER /opt/tomcat


/opt/tomcat/bin/startup.sh


git clone https://github.com/andervafla/java_deploy.git

cd java_deploy

sudo cp build/libs/class_schedule.war /opt/tomcat/webapps/


/opt/tomcat/bin/shutdown.sh
/opt/tomcat/bin/startup.sh
