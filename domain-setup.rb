# frozen_string_literal: true

def main
    puts 'If you want to delete site data, press "0"'
    puts "Enter your domain name (ex: <example.com>)"
    print "Don't use www: "
    site_name = gets.chomp
  
    def build_site(site_name)
      constans_command = "apt update -y && apt install certbot -y && apt-get install python3-certbot-apache"
      system(constans_command)
      just_name = site_name.split(".")[0]
      puts just_name
      command1 = "touch /etc/apache2/sites-available/#{site_name}.conf"
      command2 = "mkdir /var/www/#{site_name}"
      puts "*****************"
      system(command1)
      system(command2)
      system("touch /var/www/#{site_name}/index.html")
      system("echo 'successful' > /var/www/#{site_name}/index.html")
      site_configuration = "

<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.#{site_name}

        ServerName #{site_name}
        ServerAlias www.#{site_name}
        DocumentRoot /var/www/#{site_name}

        <Directory />
            Options FollowSymLinks
            AllowOverride All
        </Directory>
        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with 'a2disconf'.
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
      "
      system("echo '#{site_configuration}' > /etc/apache2/sites-available/#{site_name}.conf")
    end
  
    def create_ssl(site_name)
      system("a2ensite #{site_name}.conf")
      system("systemctl reload apache2")
      just_name = site_name.split(".")[0]
      system("certbot --apache -d #{site_name} -d www.#{site_name}")
      system("certbot renew --dry-run")
    end
  
    def finish
      system("systemctl restart apache2")
    end
  
    def delete_site
      puts "soon..."
    end
  
    if site_name == "0"
      delete_site
    else
      build_site(site_name)
      create_ssl(site_name)
      finish
    end
  end
  
  main
