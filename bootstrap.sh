#!/usr/bin/env bash
set -euo pipefail

echo "🔍 Detecting OS..."

if [[ -f /etc/arch-release ]]; then
  echo "🟦 Arch Linux detected"
  ./arch/packages.sh

elif [[ -f /etc/debian_version ]]; then
  echo "🟧 Debian/Ubuntu detected"
  ./debian/packages.sh

else
  echo "❌ Unsupported OS"
  exit 1
fi

./install.sh

echo "✅ Bootstrap complete. Log out and back in."
