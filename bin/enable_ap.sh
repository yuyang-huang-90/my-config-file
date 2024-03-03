#! /bin/bash
set -x

ifconfig wlp2s0 192.168.128.1

sudo systemctl restart hostapd
sudo systemctl restart dnsmasq

sudo iptables -A FORWARD -i eno1 -o wlp2s0 -j ACCEPT
sudo iptables -A FORWARD -i wlp2s0 -o eno1 -j ACCEPT
sudo iptables -t nat -A POSTROUTING  -o eno1 -j MASQUERADE
