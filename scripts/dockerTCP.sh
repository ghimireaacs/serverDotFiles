#!/bin/bash

# This script automates the configuration of the Docker daemon to allow
# remote connections over TCP port 2375.
# It must be run with root privileges (e.g., using sudo).

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Check for Root Privileges ---
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root. Please use sudo." >&2
  exit 1
fi

echo "--- Step 1: Creating Docker daemon.json configuration ---"
# Create the /etc/docker directory if it doesn't exist
mkdir -p /etc/docker

# Create the daemon.json file
cat <<EOF > /etc/docker/daemon.json
{"hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]}
EOF

echo "File /etc/docker/daemon.json created successfully."
echo ""

echo "--- Step 2: Creating systemd override file ---"
# Create the override directory
mkdir -p /etc/systemd/system/docker.service.d

# Create the override.conf file
cat <<EOF > /etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd
EOF

echo "File /etc/systemd/system/docker.service.d/override.conf created successfully."
echo ""

echo "--- Step 3: Reloading systemd and restarting Docker ---"
systemctl daemon-reload
systemctl restart docker.service
echo "Docker service has been restarted."
echo ""

echo "--- Step 4: Verifying Docker service status ---"
# Give the service a moment to start up before checking status
sleep 2
systemctl status docker.service --no-pager

echo ""
echo "Setup complete. Docker should now be accessible over TCP port 2375."
