#!/bin/bash
yum -y install python3-pip
pip3 install https://github.com/shadowsocks/shadowsocks/archive/master.zip
mkdir /etc/shadowsocks

touch /etc/shadowsocks/config.json
cat << EOF > /etc/shadowsocks/config.json
{
    "server":"::",
    "server_port":XXXX,
    "local_address": "127.0.0.1",
    "local_port":XXXX,
    "password":"XXXXXXXX",
    "timeout":300,
    "method":"XXXXXXXX",
    "fast_open": false
}
EOF

touch /etc/systemd/system/shadowsocks-client.service
cat << EOF > /etc/systemd/system/shadowsocks-client.service
[Unit]
Description=Shadowsocks Client Service
After=network.target
After=network-online.target

[Service]
Type=forking
User=root
ExecStart=/usr/local/bin/sslocal -c /etc/shadowsocks/config.json -d start

[Install]
WantedBy=multi-user.target
EOF

systemctl start shadowsocks-client
systemctl enable shadowsocks-client

