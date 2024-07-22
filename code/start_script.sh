sudo apt-get update
sudo apt install -y apache2
echo "IXT65 $(date) - $(hostname -i)" > /var/www/html/index.html
sudo systemctl restart apache2