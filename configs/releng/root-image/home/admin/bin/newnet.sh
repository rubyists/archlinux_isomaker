#!/bin/sh
function myip {
  device=$1
  dev=${device:-eth0}
  ip -o a l dev $dev|awk '$3=="inet"{print $4}'|head -1
}
function mygateway {
  ip route list default|awk '$1=="default"{print $3}'
}
function device_list {
  ip l l|awk '$1~/[0-9]+:/&&$2!="lo:"{sub(":","",$2);print $2}'
}

devices=$(device_list|awk '{print $1, $1}')
dialog --title "Device to use?" \
  --menu "Choose a Device" 10 15 5 $devices 2>/tmp/netdev
device=$(</tmp/netdev)
rm /tmp/netdev
clear
ip=$(myip $device|awk -F"/" '{print $1}')
netmask=$(myip $device|awk -F"/" '{print $2}')
gateway=$(mygateway)
dialog --title "Set up $device Network" \
  --begin 0 0 \
  --inputbox "IP Address" 8 24 "$ip"  --clear \
  --begin 0 24 \
  --inputbox "Netmask (/cidr)" 8 24 "/$netmask"  --clear \
  --begin 0 0 \
  --inputbox "Gateway IP" 8 24 "$gateway" --clear \
  --begin 0 24 \
  --inputbox "Primary DNS" 8 24 8.8.8.8 --clear \
  --begin 0 0 \
  --inputbox "Secondary DNS" 8 24 4.2.2.2 2>/tmp/networking
if [ $? -ne 0 ];then
  echo "An error occurred, aborting"
  exit
fi
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
INTERFACE='$device'
IP='static'
ADDR='$ip'
NETMASK='$netmask'
GATEWAY='$gateway'
DNS=('$dns1' '$dns2')" > /etc/network.d/rubyists-ethernet
  sudo netcfg rubyists-ethernet
else
  echo "Network Configuration Cancelled"
fi
