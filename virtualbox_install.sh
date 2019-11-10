#!/usr/bin/env bash
# virtualbox
# https://www.virtualbox.org/wiki/Linux_Downloads
sudo add-apt-repository \
    "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian \
    $(lsb_release -cs) \
    contrib"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install virtualbox-6.0 virtualbox-ext-pack
sudo usermod -aG vboxusers $USER

