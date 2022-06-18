#!/bin/bash
apt update
apt install -y squid3
sed -i 's/#http_access allow localnet/http_access allow localnet/' /etc/squid/squid.conf
sed -i '/acl localnet src 192.168.0.0.*/aacl localnet src 123.0.0.0\/24' /etc/squid/squid.conf
echo "127.0.0.1 client_2_proxy" >> /etc/hosts
echo "visible_hostname client_2_proxy" >> /etc/squid/squid.conf
service squid restart
