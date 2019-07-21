#!/usr/bin/env bash
# vagrant
# https://www.vagrantup.com/downloads.html
VAGRANT_VERSION="2.2.3"
wget -P ${HOME}/Downloads tmp https://releases.hashicorp.com/vagrant/2.2.3/vagrant_${VAGRANT_VERSION}_x86_64.deb
sudo dpkg -i ${HOME}/Downloads/vagrant_${VAGRANT_VERSION}_x86_64.deb
if [ $? -ne 0 ]; then
    sudo apt-get -f -y install
    sudo dpkg -i ${HOME}/Downloads/vagrant_${VAGRANT_VERSION}_x86_64.deb
fi

