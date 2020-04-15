#!/usr/bin/env bash
# https://f001.backblazeb2.com/file/hendricks/scripts/docker-tls/02-configure-docker-systemd.sh
# Configuring Docker to use TLS with systemd socket
# https://docs.docker.com/engine/reference/commandline/dockerd//#daemon-configuration-file

echo '{
  "tls": true,
  "tlscacert": "/etc/docker/ssl/ca.pem",
  "tlscert": "/etc/docker/ssl/cert.pem",
  "tlskey": "/etc/docker/ssl/key.pem",
  "tlsverify": true
}' | sudo tee /etc/docker/daemon.json

# Configuring systemd socket to listen on TCP
# https://github.com/docker/docker/issues/25471#issuecomment-238076313
sudo mkdir -p /etc/systemd/system/docker.socket.d
echo '[Socket]
ListenStream=unix:///var/run/docker.sock
ListenStream=0.0.0.0:2376' | sudo tee /etc/systemd/system/docker.socket.d/tcp_secure.conf
sudo systemctl daemon-reload
sudo service docker restart

