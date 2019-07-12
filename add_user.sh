#!/usr/bin/env bash
# add user
sudo adduser $1
# add docker access authority to the user
sudo usermod -a $1 -G docker
sudo groups $1
