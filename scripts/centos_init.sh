#!/bin/bash

SERVER_HOME=`pwd`
echo SERVER_HOME=$(SERVER_HOME)

yum -y update
yum -y install ctags git cscope
yum install -y gcc gcc-c++ kernel-devel
yum install -y pcre pcre-devel
yum install -y zlib zlib-devel
yum install -y openssl openssl-devel
yum install -y vim-enhanced wget curl
yum install -y libffi-devel
yum install -y bzip2-devel
yum install -y net-tools
yum install -y sysstat #sar工具
yum install -y psmisc #pstree工具,killall杀进程的
yum install -y iptraf-ng #流量监控
yum install -y bash-completion #systemctl命令补全

exit 0

# samba
#yum -y install samba
#cp ${SERVER_HOME}/etc/samba/smb.conf /etc/samba/smb.conf
#smbpasswd -a root
#service smbd restart
firewall-cmd --add-service=samba --zone=public --permanent
firewall-cmd --reload
setenforce 0
smbpasswd -a root

# development tools
dnf group -y install "Development Tools"
dnf install llvm-toolset
dnf install gdb valgrind systemtap ltrace strace
dnf install yum-utils
dnf install perf papi pcp-zeroconf valgrind strace sysstat systemtap
dnf module install -y container-tools

# yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --add-repo  http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo 
dnf install containerd.io docker-ce docker-ce-cli

# git
yum install connect-proxy
# configuration
# .ssh/config

