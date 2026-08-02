#!/bin/bash
# 03_subdomain_enum.sh
# Run theHarvester against the target domain using only free-tier sources.
# Requires theHarvester to be installed (ships with Kali Linux by default).
# Usage: ./03_subdomain_enum.sh <target-domain>

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <target-domain>"
  exit 1
fi

DOMAIN="$1"
OUTFILE="theharvester_${DOMAIN}.txt"

echo "=== Running theHarvester against $DOMAIN ==="
theHarvester -d "$DOMAIN" -b all | tee "$OUTFILE"

echo
echo "Full output saved to $OUTFILE"
echo "IMPORTANT: candidate hostnames reported here are NOT confirmed live assets."
echo "Verify each one with 04_verify_subdomains.sh before reporting as a finding."
