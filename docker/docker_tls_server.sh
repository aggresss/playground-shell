#!/usr/bin/env bash
cd certs
sudo cp -v ca.crt /etc/docker/ssl/ca.pem
sudo cp -v server.key /etc/docker/ssl/key.pem
sudo cp -v server.crt /etc/docker/ssl/cert.pem

