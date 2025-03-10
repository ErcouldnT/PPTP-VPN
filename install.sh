#!/bin/bash
wan=$(ip -f inet -o addr show eth0|cut -d\  -f 7 | cut -d/ -f 1)
wlan=$(ip -f inet -o addr show wlan0|cut -d\  -f 7 | cut -d/ -f 1)
ppp1=$(/sbin/ip route | awk '/default/ { print $3 }')
ip=$(dig +short myip.opendns.com @resolver1.opendns.com)

# Installing pptpd
echo "Installing PPTPD"
sudo apt install pptpd -y

# edit DNS
echo "Setting Cloudflare DNS"
sudo echo "ms-dns 1.1.1.1" >> /etc/ppp/pptpd-options
sudo echo "ms-dns 1.0.0.1" >> /etc/ppp/pptpd-options

# Edit PPTP Configuration
echo "Editing PPTP Configuration"
remote="$ppp1"
remote+="0-200"
sudo echo "localip $ppp1" >> /etc/pptpd.conf
sudo echo "remoteip $remote" >> /etc/pptpd.conf

# Enabling IP forwarding in PPTP server
echo "Enabling IP forwarding in PPTP server"
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sudo sysctl -p

# Tinkering in Firewall
echo "Tinkering in Firewall"
if [ -z "$wan" ]
	then
		sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE && iptables-save
		sudo iptables --table nat --append POSTROUTING --out-interface ppp0 -j MASQUERADE
		$("sudo iptables -I INPUT -s $ip/8 -i ppp0 -j ACCEPT")
		sudo iptables --append FORWARD --in-interface wlan0 -j ACCEPT
	else
		sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE && iptables-save
		sudo iptables --table nat --append POSTROUTING --out-interface ppp0 -j MASQUERADE
		$("sudo iptables -I INPUT -s $ip/8 -i ppp0 -j ACCEPT")
		sudo iptables --append FORWARD --in-interface eth0 -j ACCEPT
fi

clear

# Adding VPN Users
echo "Set username:"
read username
echo "Set Password:"
read password
sudo echo "$username * $password *" >> /etc/ppp/chap-secrets

# Restarting Service 
sudo service pptpd restart

echo "All done!"
