#!/usr/bin/env bash

rm -rf /var/lib/mysql
/usr/bin/mysql_install_db --user=mysql --ldata=/var/lib/mysql
/usr/bin/mysqld_safe & sleep 5s

mysql -uroot -e "CREATE DATABASE wordpress; GRANT ALL PRIVILEGES ON development_hr.* TO 'root'@'%'; FLUSH PRIVILEGES;"
killall mysqld
sleep 5s
echo "Starting supervisord"
supervisord -n