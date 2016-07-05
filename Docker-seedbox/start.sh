#!/bin/bash
set -e

/usr/sbin/php-fpm -D

chmod 777 /run/php-fpm/www.sock

nginx

chown -R seeduser.seeduser /home/seeduser

su - seeduser -p -c rtorrent

