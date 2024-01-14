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

# Update .env File
echo "MYSQL_HOST=localhost" > ../.env
echo "MYSQL_USER=$DB_USER" >> ../.env
echo "MYSQL_PASSWORD=$DB_PASS" >> ../.env
echo "MYSQL_DATABASE=$DB_NAME" >> ../.env
echo "JWT_SECRET=$(openssl rand -base64 32)" >> ../.env

echo "Created the .env file"