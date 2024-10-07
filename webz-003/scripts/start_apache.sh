#!/bin/bash

# Enable headers module
a2enmod headers

# appends a directive to the default Apache configuration to set a custom HTTP header 
echo 'Header set Node-IP "172.20.0.4"' >> /etc/apache2/sites-available/000-default.conf
echo 'Header set Node-Name "webz-003"' >> /etc/apache2/sites-available/000-default.conf

# Configure Apache
echo "Junior DevOps Engineer - Home Task" > /var/www/html/index.html

service apache2 restart