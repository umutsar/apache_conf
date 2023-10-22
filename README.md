# apache_conf

Example apache2 domain configuration file with SSL but you need to create SSL before execute this configuration.

# Creating domain files.

sudo mkdir /var/www/example.com

sudo nano /etc/apache2/sites-available/example.com.conf (content of this file should be example.com.conf that I gave you.)

sudo a2ensite example.com.conf

sudo systemctl restart apache2 (or you can use reload instead of restart. This reloads the server without interruption)

# SSL

sudo apt update

sudo apt install certboot

sudo certbot certonly --webroot -w /var/www/example.com -d example.com -d www.example.com

sudo a2ensite example.com.conf

sudo systemctl restart apache2

# !!! If you have errors and you can't solve them, execute below steps:

sudo apt-get -o DPkg::Options::="--force-confmiss" --reinstall install apache2

sudo apt-get purge apache2

sudo apt-get install apache2
