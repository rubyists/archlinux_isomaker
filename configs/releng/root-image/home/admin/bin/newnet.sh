#!/bin/sh
ip=$(myip.sh|awk -F"/" '{print $1}')
netmask=$(myip.sh|awk -F"/" '{print $2}')
gateway=$(mygateway.sh)
clear
dialog --title "Set up a network" \
  --begin 2 2 \
  --inputbox "IP Address" 8 24 "$ip"  --clear \
  --inputbox "Netmask (/cidr)" 8 24 "/$netmask"  --clear \
  --inputbox "Gateway IP" 8 24 "$gateway" --clear \
  --inputbox "Primary DNS" 8 24 8.8.8.8 --clear \
  --inputbox "Secondary DNS" 8 24 4.2.2.2  2>/tmp/networking

read ip mask gateway dns1 dns2 < /tmp/networking
rm /tmp/networking
netmask=${mask#/*}
a="IP: $ip
Netmask: /$netmask
Gateway: $gateway
DNS 1: $dns1
DNS 2: $dns2"
dialog --title "Confirm Settings" --begin 2 2 --msgbox "$a" 10 30 --and-widget --begin 12 2 --yesno Apply? 5 16
if [ $? -eq 0 ];then
  echo "Applying Settings"
  sudo netcfg -a
  echo "CONNECTION='ethernet'
DESCRIPTION='A basic static ethernet connection using iproute'
INTERFACE='eth0'
IP='static'
ADDR='$ip'
NETMASK='$netmask'
GATEWAY='$gateway'
DNS=('$dns1' '$dns2')" > /etc/network.d/rubyists-ethernet
  sudo netcfg rubyists-ethernet
else
  echo "Network Configuration Cancelled"
fi
