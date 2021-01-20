#!/bin/bash
sudo nice -n -20 /home/pi/HX711C/HX711 > /home/pi/log.txt &

/home/pi/websocketd --port=8080 --staticdir=/var/www/html/ tail -f /home/pi/log.txt &
