#!/bin/bash

set -eu

#### This is for local development purposes only
## Do not use this method for anything non-local

# used by the backend
DB_NAME="devopshub"
DB_USER="devopshub"
DB_PASS="hunter2"

# Create Database
sudo mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
echo "Created database: $DB_NAME"

# Create User and Grant Permissions
sudo mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"
echo "Created user: $DB_USER and granted privileges"

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Update .env File
echo "MYSQL_HOST=localhost" > $SCRIPT_DIR/../.env
echo "MYSQL_USER=$DB_USER" >> $SCRIPT_DIR/../.env
echo "MYSQL_PASSWORD=$DB_PASS" >> $SCRIPT_DIR/../.env
echo "MYSQL_DATABASE=$DB_NAME" >> $SCRIPT_DIR/../.env
echo "JWT_SECRET=$(openssl rand -base64 32)" >> $SCRIPT_DIR/../.env

echo "Created the .env file"