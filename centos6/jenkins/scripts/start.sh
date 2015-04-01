#!/usr/bin/env bash

/usr/bin/mysqld_safe & sleep 10s

mysql -uroot -e "CREATE DATABASE wordpress; GRANT ALL PRIVILEGES ON development_hr.* TO 'root'@'%'; FLUSH PRIVILEGES;"
killall mysqld
sleep 10s
supervisord -n