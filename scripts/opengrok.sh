#!/bin/bash

sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get -y install openjdk-11-jdk-headless

# opengrok
mkdir -p /opt/codesearch
mkdir -p /opt/codesearch/opengrok
mkdir -p /opt/codesearch/opengrok/project
mkdir -p /opt/codesearch/opengrok/log
mkdir -p /opt/codesearch/opengrok/data
mkdir -p /opt/codesearch/opengrok/data/suggester
mkdir -p /opt/codesearch/opengrok/opengrok_etc
cd /opt/codesearch/opengrok
wget https://github.com/oracle/opengrok/releases/download/1.7.40/opengrok-1.7.40.tar.gz
tar -xf opengrok-1.7.40.tar.gz
ln -s opengrok-1.7.40 latest
cd -

mkdir -p /opt/codesearch/tomcat
cd /opt/codesearch/tomcat
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.2/bin/apache-tomcat-10.1.2.tar.gz
tar -xf apache-tomcat-10.1.2.tar.gz
ln -s apache-tomcat-10.1.2 latest
cd -

cp -rf /opt/codesearch/opengrok/latest/lib/source.war /opt/codesearch/tomcat/latest/webapps/
cd /opt/codesearch/opengrok/latest/tools
pip install opengrok-tools.tar.gz
cd -

# tomcat
cat << EOF > /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat Simple Instance

[Service]
Type=oneshot
RemainAfterExit=yes

ExecStart=/opt/tomcat/latest/bin/startup.sh

ExecStop=/opt/tomcat/latest/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF

systemctl enable tomcat
systemctl start tomcat
systemctl status tomcat

java -Xms512m -Xmx4g -Xmn2g -Xss128m -jar /opt/codesearch/opengrok/latest/lib/opengrok.jar \
    -c /opt/bin/ctags -s /opt/codesearch/opengrok/project -d /opt/codesearch/opengrok/data \
    -H -P -S -G -W /opt/codesearch/opengrok/opengrok_etc/configuration.xml --depth 15

