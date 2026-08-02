#!/bin/bash
# 01_dns_asn_lookup.sh
# DNS resolution and reverse-IP/ASN lookup against the target hostname.
# Usage: ./01_dns_asn_lookup.sh <target-hostname>

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <target-hostname>"
  exit 1
fi

TARGET="$1"
RESOLVER="8.8.8.8"

echo "=== DNS Resolution: $TARGET (via $RESOLVER) ==="
nslookup "$TARGET" "$RESOLVER"

echo
echo "=== Reverse-IP/ASN Lookup for each resolved IPv4 address ==="
IPS=$(nslookup "$TARGET" "$RESOLVER" | awk '/^Address: / {print $2}' | grep -E '^[0-9]+\.' || true)

if [ -z "$IPS" ]; then
  echo "No IPv4 addresses found to look up."
  exit 0
fi

for ip in $IPS; do
  echo "--- $ip ---"
  curl -s "ipinfo.io/$ip"
  echo
done
