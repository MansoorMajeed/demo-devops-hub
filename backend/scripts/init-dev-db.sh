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
echo "MYSQL_HOST=127.0.0.1" > $SCRIPT_DIR/../.env
echo "MYSQL_USER=$DB_USER" >> $SCRIPT_DIR/../.env
echo "MYSQL_PASSWORD=$DB_PASS" >> $SCRIPT_DIR/../.env
echo "MYSQL_DATABASE=$DB_NAME" >> $SCRIPT_DIR/../.env
echo "JWT_SECRET=$(openssl rand -base64 32)" >> $SCRIPT_DIR/../.env

echo "Created the .env file"

# The users and posts tables
sudo mysql << "EOF"
CREATE DATABASE IF NOT EXISTS devopshub;

USE devopshub;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
EOF
