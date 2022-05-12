#!/bin/bash
sudo apt update -y
sudo apt install -y apache2
echo "Terratest" > /var/www/html/index.html