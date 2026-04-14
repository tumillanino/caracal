#!/usr/bin/env bash
set -euo pipefail

rm -rf /opt/bitwig-studio
rm -f /usr/local/bin/bitwig-studio
rm -f /usr/local/lib64/libbz2.so.1.0
rm -f /usr/local/share/applications/bitwig-studio.desktop
rm -rf /usr/local/share/bitwig-studio

find /usr/local/share/icons -path '*/apps/bitwig-studio.*' -delete 2>/dev/null || true

echo "Bitwig Studio removed."
