#!/bin/bash
# 04_verify_subdomains.sh
# Independently verify a list of candidate subdomains (e.g. from theHarvester)
# at both the DNS layer and the HTTP/TLS layer, rather than accepting
# automated tool output at face value.
#
# Usage: ./04_verify_subdomains.sh <candidates-file>
# candidates-file: one hostname per line

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <candidates-file>"
  exit 1
fi

FILE="$1"
RESOLVER="8.8.8.8"

if [ ! -f "$FILE" ]; then
  echo "File not found: $FILE"
  exit 1
fi

while IFS= read -r host; do
  [ -z "$host" ] && continue
  echo "=== $host ==="

  echo "-- DNS layer --"
  nslookup "$host" "$RESOLVER" | awk '/^Address: / {print}' || echo "  no DNS resolution"

  echo "-- HTTP/TLS layer --"
  if curl -s -o /dev/null -w "  HTTP status: %{http_code}\n" -I "https://$host/" 2>/tmp/curl_err; then
    :
  else
    echo "  TLS/connection failed: $(tail -n1 /tmp/curl_err)"
  fi

  echo
done < "$FILE"
