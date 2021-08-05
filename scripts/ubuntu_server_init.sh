#!/bin/bash

SERVER_HOME=$(shell `pwd`)

echo SERVER_HOME=${SERVER_HOME}

apt-get -y update
apt-get -y upgrade

apt-get -y install ctags vim libevent-dev libncurses5-dev git cscope linux-tools-common

mkdir -p /qiuxi
mkdir -p /svn
# mkfs.ext4 /dev/sdb
mount -t ext4 /dev/sdc /qiuxi
mount -t ext4 /dev/sdb /svn
# mkdir -p /qiuxi/{wokeplace/{riscv,rtos,linux,aosp},tmp,.local,source}

rm -rf /opt
ln -s /qiuxi/.local /opt

rm -rf /root
ln -s ${SERVER_HOME}/root /root

apt -y install safe-rm
cp ${SERVER_HOME}/etc/bash.bashrc /etc/bash.bashrc


# ssh
apt -y install openssh-server
cp ${SERVER_HOME}/etc/ssh/sshd_config /etc/ssh/sshd_config
service sshd restart

# samba
apt -y install samba
cp ${SERVER_HOME}/etc/samba/smb.conf /etc/samba/smb.conf
smbpasswd -a root
service smbd restart

sudo apt -y install openjdk-8-jdk-headless
cat >> /etc/bash.bashrc << "EOF"
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib
export PATH=$JAVA_HOME/bin:$PATH
EOF
source /etc/bash.bashrc


# # svn
# svnserve -d -r /qiuxi/wokeplace/svn/svn-server --listen-port 2766

# opengrok
apt -y install autoconf automake libtool pkg-config
apt -y install python3-pip
apt -y install python-pip
apt -y install python3-venv
pip3 install https://github.com/shadowsocks/shadowsocks/archive/master.zip

# # tomcat
# # ln -s /opt/tomcat/apache-tomcat-9.0.19 /opt/tomcat/latest
# cat > /etc/init.d/tomcat << "EOF"
# #!/bin/sh
# ### BEGIN INIT INFO
# # Provides:	        tomcat
# # Required-Start:	$remote_fs $network
# # Required-Stop:	$remote_fs $network
# # Default-Start:	2 3 4 5
# # Default-Stop:		0 1 6
# # Short Description:	the tomcat Java Application Server
# ### END INIT INFO
# RETVAL=0

# start()
# {
#   if [ -f /opt/tomcat/latest/bin/startup.sh ]
# 	then
# 	  echo $"Starting Tomcat"
# 		/opt/tomcat/latest/bin/startup.sh
# 	  RETVAL=$?
# 	  echo "OK"
# 	  return $RETVAL
# 	fi
# }

# stop()
# {
# 	if [ -f /opt/tomcat/latest/bin/shutdown.sh ]
# 	then
# 	  echo $"Stopping Tomcat"
# 		/opt/tomcat/latest/bin/shutdown.sh
# 	  RETVAL=$?
# 	  sleep 3
# 	  ps -fwwu tomcat | grep apache-tomcat | grep -v grep | grep -v PID | awk '{print $2}'| xargs kill -9
# 	  echo "OK"
# 	  return $RETVAL
# 	fi
# }

# case "$1" in
# 	start)
# 		start
# 		;;
# 	stop)
# 		stop
# 		;;
# 	restart)
# 		echo $"Restarting Tomcat"
# 		$0 stop
# 		sleep 3
# 		$0 start
# 		;;
# 	*)
# 		echo $"Usage:$0{start|stop|restart}"
# 		exit 1
# 		;;
# esac
# exit $RETVAL
# EOF

# systemctl daemon-reload
# systemctl enable tomcat
# systemctl status tomcat

# java -Xms512m -Xmx4g -Xmn2g -Xss128m -jar /opt/opengrok/latest/lib/opengrok.jar \
#     -c /opt/bin/ctags -s /opt/opengrok/project -d /opt/opengrok/data \
#     -H -P -S -G -W /opt/opengrok/opengrok_etc/configuration.xml --depth 15\r


source /etc/bash.bashrc

exit 0

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup install nightly
rustup default nightly
rustup component add rls --toolchain nightly
rustup component add rust-analysis --toolchain nightly
rustup component add rust-src --toolchain nightly
rustup component add rustfmt --toolchain nightly
cargo install racer
cargo install cargo-xbuild
rustup target add arm-unknown-linux-gnueabi
rustup target add aarch64-unknown-linux-gnu

# rtthread
apt-get -y install scons
apt-get -y install qemu

apt-get -y remove libreoffice-common
apt-get -y remove transmission transmission-common transmission-gtk
apt-get -y remove thunderbird thunderbird-gnome-support thunderbird-locale-en thunderbird-locale-en-us
apt-get -y remove totem totem-common totem-plugins
apt-get -y remove rhythmbox rhythmbox-plugin-alternative-toolbar rhythmbox-plugins empathy brasero
apt-get -y remove aisleriot cheese onboard deja-dup unity-webapps-common
apt-get -y remove gnome-sudoku gnome-todo gnome-todo-common gnome-mines gnome-mahjongg gnome-calendar gnome-power-manager
apt-get -y remove remmina simple-scan shotwell file-roller

source /etc/bash.bashrc
