#!/bin/bash
service ssh start
service mysql start

a2enmod rewrite
service apache2 restart

while true
do
    sleep 404
done