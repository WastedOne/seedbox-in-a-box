#!/bin/bash
set -e

mysql_install_db --user=mysql

mysqld_safe --user=mysql &

sleep 1

mysql -u root -e "CREATE DATABASE what_manager2 COLLATE utf8_unicode_ci;"

mysql -u root -e "CREATE USER 'whatuser'@'localhost' IDENTIFIED BY 'whatpass';"

mysql -u root -e "GRANT ALL PRIVILEGES ON what_manager2.* TO 'whatuser'@'localhost';"

/home/what/WhatManager2/manage.py migrate

mysql -u root -e "INSERT INTO what_manager2.auth_user VALUES (1,'pbkdf2_sha256\$20000\$XEBfC6ToXIeT\$M/IKPbrrocyDZo4CwA3fQ7Ih9focJfExkA8WDK8KZEs=',NULL,1,'whatwmuser','','','whatwmuser@host.com',1,1,'2016-07-21 11:57:30.922264');"

mysql -u root -e "INSERT INTO what_manager2.home_downloadlocation VALUES (1,'what.cd','/home/what/temp',1);"

mkdir /home/what/temp

chmod 777 /home/what/temp

chmod 755 /home/what

mysql -u root -e "INSERT INTO what_manager2.home_replicaset VALUES (1,'what.cd','master'),(2,'bibliotik.me','master');"

mysql -u root -e "INSERT INTO what_manager2.home_transinstance VALUES (1,'what01','0.0.0.0',9091,21413,'transmission','9dqQQ2WW',1);"

su - what -c 'transmission-daemon -g /home/what/Torrent/transmission-daemon/what01 -w /home/what/temp -a 0.0.0.0'

rabbitmq-server &

httpd

su - what -c 'python /home/what/WhatManager2/manage.py celery worker --loglevel=info --concurrency=1' &

su - what -c 'while true; do curl http://localhost/transcode/update && sleep 60 ; done' &

su - what -c 'while true; do curl --user whatwmuser:whatwmpass --connect-timeout 60 --max-time 120 http://localhost/json/sync && sleep 30 ; done'


