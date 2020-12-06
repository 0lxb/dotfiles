yum -y update

# samba
yum -y install samba
firewall-cmd --add-service=samba --zone=public --permanent
firewall-cmd --reload
smbpasswd -a root

# development tools
dnf group -y install "Development Tools"
dnf install llvm-toolset
dnf install gdb valgrind systemtap ltrace strace
dnf install yum-utils
dnf install perf papi pcp-zeroconf valgrind strace sysstat systemtap
dnf module install -y container-tools

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf install containerd.io docker-ce docker-ce-cli

# git
yum install connect-proxy
# configuration
# .ssh/config

