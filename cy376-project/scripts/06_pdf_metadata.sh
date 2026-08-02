#!/bin/bash
# 06_pdf_metadata.sh
# Extract embedded metadata from a downloaded PDF using exiftool.
# Usage: ./06_pdf_metadata.sh <path-to-pdf>

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <path-to-pdf>"
  exit 1
fi

FILE="$1"

if [ ! -f "$FILE" ]; then
  echo "File not found: $FILE"
  exit 1
fi

echo "=== Metadata for $FILE ==="
exiftool "$FILE"
