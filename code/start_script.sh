apt update
apt install -y apache2
echo "IXT65 $(date) - $(hostname -i)" > /var/www/html/index.html
systemctl restart apache2