#!/bin/bash

# Install php 7.3
sudo add-apt-repository ppa:ondrej/php -y # Press enter to confirm.
sudo apt-get update
sudo apt install php7.3 php7.3-common php7.3-cli -y
sudo apt install php7.3-bcmath php7.3-bz2 php7.3-curl php7.3-gd php7.3-intl php7.3-json php7.3-mbstring php7.3-readline php7.3-xml php7.3-zip -y
sudo apt install php7.3-fpm

sudo sed -i -e s/index\.nginx-debian\.html/index\.php/g /etc/nginx/sites-available/default
sudo sed -i -e s/php7\.0-fpm\.sock/php7\.3-fpm\.sock/g /etc/nginx/sites-available/default

sudo sed -i -e '56s/#//' /etc/nginx/sites-available/default
sudo sed -i -e '57s/#//' /etc/nginx/sites-available/default
sudo sed -i -e '58s/#//' /etc/nginx/sites-available/default
sudo sed -i -e '60s/#//' /etc/nginx/sites-available/default
sudo sed -i -e '63s/#//' /etc/nginx/sites-available/default

## Set index page
echo "<h1>Hello world and more...</h2><?php phpinfo(); ?>" | sudo tee /var/www/html/index.php
sudo chmod +x /var/www/html/index.php
sudo rm -f /var/www/html/index.html

sudo service nginx restart
