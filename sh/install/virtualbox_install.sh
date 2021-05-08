#!/usr/bin/env bash
# virtualbox
# https://www.virtualbox.org/wiki/Linux_Downloads

echo \
  "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian \
  $(lsb_release -cs) \
  contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list > /dev/null


wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install virtualbox-6.1
sudo usermod -aG vboxusers $USER
