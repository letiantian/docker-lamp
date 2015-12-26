#!/bin/bash
service ssh restart
service mysql restart
service apache2 restart

while true
do
    sleep 404
done