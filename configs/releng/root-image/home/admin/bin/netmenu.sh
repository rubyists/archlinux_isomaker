#!/bin/bash
ip=$(myip.sh)
echo "menu:netcfg:Network:Connect to a Network"
echo "exec:Set up Network with _DHCP:pause:dhcpcd eth0"
echo "exec:Set up Network _Manually::newnet.sh"
echo "nop:"
echo "nop:Current IP -> $ip"
echo "exit:Network _Menu.."

