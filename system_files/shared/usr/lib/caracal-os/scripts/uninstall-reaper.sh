#!/usr/bin/env bash
set -euo pipefail

rm -rf /opt/REAPER
rm -f /usr/local/share/applications/cockos-reaper.desktop
rm -f /usr/local/share/pixmaps/reaper.png

echo "REAPER removed."
