#!/bin/bash

# This script automates the configuration of the Docker daemon to allow
# remote connections over TCP port 2375 and configures the UFW firewall accordingly.
# It must be run with root privileges (e.g., using sudo).

# --- Configuration & Colors ---
set -e # Exit immediately if a command exits with a non-zero status.

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# --- Script Start ---

# Check for Root Privileges
if [ "$(id -u)" -ne 0 ]; then
  echo -e "${YELLOW}This script must be run as root. Please use sudo.${NC}" >&2
  exit 1
fi

echo -e "${BLUE}--- Step 1: Creating Docker daemon.json configuration ---${NC}"
mkdir -p /etc/docker
cat <<EOF > /etc/docker/daemon.json
{"hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]}
EOF
echo -e "${GREEN}✔ File /etc/docker/daemon.json created successfully.${NC}\n"

echo -e "${BLUE}--- Step 2: Creating systemd override file ---${NC}"
mkdir -p /etc/systemd/system/docker.service.d
cat <<EOF > /etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd
EOF
echo -e "${GREEN}✔ File /etc/systemd/system/docker.service.d/override.conf created successfully.${NC}\n"

echo -e "${BLUE}--- Step 3: Reloading systemd and restarting Docker ---${NC}"
systemctl daemon-reload
systemctl restart docker.service
echo -e "${GREEN}✔ Docker service has been restarted.${NC}\n"

echo -e "${BLUE}--- Step 4: Configuring UFW Firewall ---${NC}"
# Check if UFW is installed and active
if command -v ufw &> /dev/null; then
  if ufw status | grep -q "Status: active"; then
    echo "UFW is active. Adding rule to allow port 2375..."
    ufw allow 2375/tcp > /dev/null # Suppress output
    echo -e "${GREEN}✔ UFW rule added successfully.${NC}"
  else
    echo -e "${YELLOW}UFW is installed but not active. Skipping firewall configuration.${NC}"
  fi
else
  echo -e "${YELLOW}UFW is not installed. Skipping firewall configuration.${NC}"
fi
echo ""

echo -e "${BLUE}--- Step 5: Verifying Docker service status ---${NC}"
# Give the service a moment to start up before checking status
sleep 2
if systemctl is-active --quiet docker.service; then
  echo -e "${GREEN}✔ Docker service is active and running.${NC}"
else
  echo -e "${RED}❌ Docker service failed to start. Please check logs with 'journalctl -xeu docker.service'.${NC}"
  exit 1
fi
echo ""

echo -e "${GREEN}🚀 Setup complete. Docker should now be accessible over TCP port 2375.${NC}"
