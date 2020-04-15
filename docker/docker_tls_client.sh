#!/usr/bin/env bash

read -p "Please input server hostname:" input_host
if [ ${input_host:-NOCONFIG} = "NOCONFIG" ]; then
    cert_path="${HOME}/.docker"
else
    echo ${input_host}
    cert_path="${HOME}/.docker/${input_host}"
fi

cd certs
mkdir -p ${cert_path}
cp -v ca.crt ${cert_path}/ca.pem
cp -v client.key ${cert_path}/key.pem
cp -v client.crt ${cert_path}/cert.pem

