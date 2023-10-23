# apache_conf

*Example apache2 domain configuration file with SSL but you need to create SSL before execute this configuration.

! Download rb file and execute 'ruby example.rb' it shoule be setup automaticly.
 
! Most of steps which are below, only help you when it won't setup automaticly.

# Creating domain files.

*sudo mkdir /var/www/example.com

*sudo nano /etc/apache2/sites-available/example.com.conf (content of this file should be example.com.conf that I gave you.)

*sudo a2ensite example.com.conf

*sudo systemctl restart apache2 (or you can use reload instead of restart. This reloads the server without interruption)

# SSL

*sudo apt update

*sudo apt install certboot

*sudo certbot certonly --webroot -w /var/www/example.com -d example.com -d www.example.com

*sudo a2ensite example.com.conf

*sudo systemctl restart apache2

# ! If you've errors and you can't solve them, execute below steps: (if apache2.service cannot be started)

*execute `a2dissite example.com.conf

(if this commannd doesn't solve look at below options and execute by step by.)

*sudo apt-get -o DPkg::Options::="--force-confmiss" --reinstall install apache2

*sudo apt-get purge apache2

*sudo apt-get install apache2

*service apache2 start

# If you are getting certbot ssl error;

*sudo certbot delete --cert-name example.com

# Extra information

*Error documents: /usr/share/apache2/error

*Activation site configuration: a2ensite example.com.conf

*Deactivation site configuration: a2dissite example.conf







