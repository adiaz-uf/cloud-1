#!/bin/bash

sleep 10

# Check if WordPress is already installed by verifying if the database has tables
if wp core is-installed --allow-root 2>/dev/null; then
	echo "WordPress is already installed"
	
	# update urls
	echo "Updating WordPress URLs to: $DOMAIN_NAME"
	wp option update home "https://$DOMAIN_NAME" --allow-root
	wp option update siteurl "https://$DOMAIN_NAME" --allow-root
	
	# check urls
	echo "Current home URL: $(wp option get home --allow-root)"
	echo "Current site URL: $(wp option get siteurl --allow-root)"
else
	echo "Installing WordPress..."
	
	# Download WordPress core if not present
	if [ ! -f ./wp-config.php ]; then
		wp core download --allow-root
		wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --allow-root
		
		wp config set WP_HOME "https://$DOMAIN_NAME" --allow-root
		wp config set WP_SITEURL "https://$DOMAIN_NAME" --allow-root
	fi
	
	# Install WordPress
	wp core install --allow-root --url="https://$DOMAIN_NAME" --title="$WORDPRESS_TITLE" --admin_user=$WORDPRESS_ADMIM --admin_password=$WORDPRESS_ADMIM_PASS  --admin_email=$WORDPRESS_ADMIM_EMAIL --skip-email
	
	wp option update home "https://$DOMAIN_NAME" --allow-root
	wp option update siteurl "https://$DOMAIN_NAME" --allow-root
	
	# Update plugins
	wp plugin update --path="." --allow-root --all
	
	# Create additional user
	wp user create $WORDPRESS_USER $WORDPRESS_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASS --allow-root
	
	# Install and activate theme
	wp theme install twentytwentythree --activate --allow-root
	
	echo "WordPress installation completed"
	echo "Home URL: $(wp option get home --allow-root)"
	echo "Site URL: $(wp option get siteurl --allow-root)"
fi

php-fpm7.4 -F
