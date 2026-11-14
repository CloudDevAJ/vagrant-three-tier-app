#!/bin/bash
set -e

echo "=== Installing MySQL on DB VM ==="

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y mysql-server

sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' \
  /etc/mysql/mysql.conf.d/mysqld.cnf

systemctl enable mysql
systemctl restart mysql

mysql <<'SQL'
CREATE DATABASE IF NOT EXISTS appdb;

CREATE USER IF NOT EXISTS 'appuser'@'192.168.56.%'
IDENTIFIED WITH mysql_native_password BY 'AppPassword123!';

ALTER USER 'appuser'@'192.168.56.%'
IDENTIFIED WITH mysql_native_password BY 'AppPassword123!';

GRANT ALL PRIVILEGES ON appdb.* TO 'appuser'@'192.168.56.%';

FLUSH PRIVILEGES;

USE appdb;

CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255) NOT NULL
);

INSERT INTO messages (message)
SELECT 'Database VM is working'
WHERE NOT EXISTS (
    SELECT 1
    FROM messages
    WHERE message = 'Database VM is working'
);
SQL

echo "=== DB VM ready ==="