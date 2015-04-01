#!/usr/bin/env bash

service mysqld start
mysql -uroot -e "CREATE DATABASE wordpress; GRANT ALL PRIVILEGES ON development_hr.* TO 'root'@'%'; FLUSH PRIVILEGES;"
