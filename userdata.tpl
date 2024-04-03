#!/bin/bash
echo "*** Installing apache2"
sudo apt update -y &&
sudo apt install apache2 -y
sudo systemctl enable apache2
echo "*** Completed Installing apache2"
