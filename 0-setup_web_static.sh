#!/usr/bin/env bash
# This script sets up web servers for deployment of web_static

# Install Nginx if not already installed
if ! command -v nginx &> /dev/null; then
    apt-get -y update
    apt-get -y install nginx
fi

# Create required directories if not already exist
mkdir -p /data/web_static/releases/test /data/web_static/shared

# Create a fake HTML file
echo "<html>
<head>
</head>
<body>
Holberton School
</body>
</html>" > /data/web_static/releases/test/index.html

# Create symbolic link
ln -sf /data/web_static/releases/test/ /data/web_static/current

# Change ownership recursively to ubuntu user and group
chown -R ubuntu:ubuntu /data/

# Update Nginx configuration
config_block="
    location /hbnb_static/ {
        alias /data/web_static/current/;
        index index.html;
    }
"
sed -i "/^\s*server_name\s*localhost;/a $config_block" /etc/nginx/sites-available/default

# Restart Nginx
service nginx restart

exit 0
