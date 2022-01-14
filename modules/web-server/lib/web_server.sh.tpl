#!/bin/bash
apt update -y
apt install apache2 -y
systemctl start apache2
bash -c 'echo The webpage is fully functioning! > /var/www/html/index.html'