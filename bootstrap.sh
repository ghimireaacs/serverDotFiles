#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Detecting OS..."

if [[ -f /etc/arch-release ]]; then
  echo "Arch Linux detected"
  bash "$SCRIPT_DIR/arch/packages.sh"

elif grep -qi "ubuntu" /etc/os-release 2>/dev/null; then
  echo "Ubuntu detected"
  bash "$SCRIPT_DIR/ubuntu/packages.sh"

elif [[ -f /etc/debian_version ]]; then
  echo "Debian detected"
  bash "$SCRIPT_DIR/debian/packages.sh"

else
  echo "Unsupported OS"
  exit 1
fi

bash "$SCRIPT_DIR/install.sh"

echo "Bootstrap complete. Log out and back in."
