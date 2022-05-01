#!/bin/bash
apt update
apt upgrade -y
apt install -y openvpn libpcap-dev tor privoxy polipo nodejs build-essential make cmake autoconf automake autogen gcc g++ haproxy socat netcat tor apt-transport-https apt-transport-tor curl libcurl4-openssl-dev mcrypt bison sqlite3 libsqlite3-dev ruby ruby-dev python python3 python3-dev python-dev python-pip python3-pip
exit 0


