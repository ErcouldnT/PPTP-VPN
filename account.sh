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

