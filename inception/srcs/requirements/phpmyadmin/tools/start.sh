#!/bin/bash

set -e  # Exit on error

# If directory is empty, copy PHPMyAdmin
if [ ! -f /var/www/phpmyadmin/index.php ]; then
    echo "Installing PHPMyAdmin to volume..."
    
    # Create tmp directory and download PHPMyAdmin
    cd /tmp
    echo "Downloading PHPMyAdmin..."
    wget -q https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.tar.gz
    
    echo "Extracting PHPMyAdmin..."
    tar xzf phpMyAdmin-5.2.1-all-languages.tar.gz
    
    # Copy files into volume
    echo "Copying files to /var/www/phpmyadmin/..."
    cd phpMyAdmin-5.2.1-all-languages
    cp -r . /var/www/phpmyadmin/
    cd ..
    
    # Cleanup
    rm -rf /tmp/phpMyAdmin-5.2.1-all-languages*
    
    # Set permissions
    chown -R www-data:www-data /var/www/phpmyadmin
    chmod -R 755 /var/www/phpmyadmin
    
    echo "PHPMyAdmin installed successfully"
else
    echo "PHPMyAdmin already installed, skipping download..."
fi

# Create PHPMyAdmin configuration file
cat > /var/www/phpmyadmin/config.inc.php << EOF
<?php
\$cfg['blowfish_secret'] = 'H2OxcGXxflSd8JwrwVlh6KW6s2rER63i';

\$i = 0;
\$i++;
\$cfg['Servers'][\$i]['auth_type'] = 'cookie';
\$cfg['Servers'][\$i]['host'] = '${MYSQL_HOSTNAME}';
\$cfg['Servers'][\$i]['port'] = '3306';
\$cfg['Servers'][\$i]['compress'] = false;
\$cfg['Servers'][\$i]['AllowNoPassword'] = false;

\$cfg['UploadDir'] = '';
\$cfg['SaveDir'] = '';
\$cfg['TempDir'] = '/tmp';
?>
EOF

chmod 644 /var/www/phpmyadmin/config.inc.php

echo "PHPMyAdmin configured successfully"

# Start PHP-FPM in foreground
php-fpm7.4 -F
