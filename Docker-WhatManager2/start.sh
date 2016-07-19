#!/bin/bash
set -e

su - what -c 'transmission-daemon -g /home/what/Torrent/transmission-daemon/what01 -w /home/what/temp'

rabbitmq-server &

httpd

su - what -c 'python manage.py celery worker --loglevel=info --concurrency=1' &

su - what -c 'while true; do curl http://localhost/transcode/update && sleep 60 ; done' &

su - what -c 'while true; do curl --user whatwmuser:whatwm2pw --connect-timeout 60 --max-time 120 http://localhost/json/sync && sleep 30 ; done' &

