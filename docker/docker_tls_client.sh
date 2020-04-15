#!/usr/bin/env bash
cd certs
mkdir -p ${HOME}/.docker
cp -v ca.crt ${HOME}/.docker/ca.pem
cp -v client.key ${HOME}/.docker/key.pem
cp -v client.crt ${HOME}/.docker/cert.pem
