#!/usr/bin/env bash
cd certs
mkdir -p /etc/docker/ssl
sudo cp -v ca.crt /etc/docker/ssl/ca.pem
sudo cp -v server.key /etc/docker/ssl/key.pem
sudo cp -v server.crt /etc/docker/ssl/cert.pem

