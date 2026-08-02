#!/bin/bash
# 02_http_headers.sh
# Capture and display raw HTTP response headers for the target.
# Usage: ./02_http_headers.sh <target-url>
# Example: ./02_http_headers.sh https://meridiancovelogistics.netlify.app/

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <target-url>"
  exit 1
fi

URL="$1"

echo "=== HTTP Response Headers: $URL ==="
curl -I -s "$URL"

echo
echo "=== Header hardening check ==="
HEADERS=$(curl -I -s "$URL")

for h in "Content-Security-Policy" "X-Content-Type-Options" "X-Frame-Options" "Referrer-Policy" "Permissions-Policy" "Strict-Transport-Security"; do
  if echo "$HEADERS" | grep -qi "^$h:"; then
    echo "[present] $h"
  else
    echo "[MISSING] $h"
  fi
done
