# PPTP-VPN by Ercode
PPTP VPN Installer Script (Cloudflare DNS-ready)

A Point-To-Point Tunneling Protocol (PPTP) allows you to implement your own VPN very quickly, and is compatible with most mobile devices. Even though PPTP is less secure than OpenVPN, it is also faster and uses less CPU resources.

Tested on Ubuntu 22.04 LTS (AWS EC2)

## Install
1. Copy script by using \
`wget https://raw.githubusercontent.com/ErcouldnT/PPTP-VPN/master/install.sh`
2. Run using `sudo bash install.sh`
3. Script will ask you **username** and **password** for VPN, set them correctly.
4. *(Optional)* If you'd like to create more accounts \
`wget https://raw.githubusercontent.com/ErcouldnT/PPTP-VPN/master/account.sh`
5. Connect the VPN and enjoy :)

## AWS EC2
1. Set up a 12-months free tier EC2 instance.
2. Open TCP 1723 port from Network Security section.
3. Apply installation script by following the steps above.
4. Use IPv4 address with your username and pw to connect your VPN.

&copy; 2022 Ercode