#!/bin/bash
set -e

su - what -p -c transmission-daemon -g /home/what/Torrent/transmission-daemon/what01 -w /home/what/temp

su - what -p -c while true; do curl http://localhost/transcode/update && sleep 60 ; done &

su - what -p -c awhile true; do curl --user whatwmuser:whatwm2pw --connect-timeout 60 --max-time 120 http://localhost/json/sync && sleep 30 ; done &

rabbitmq-server&

su -c what -p -c python manage.py celery worker --loglevel=info --concurrency=1 &

httpd -D FOREGROUND

