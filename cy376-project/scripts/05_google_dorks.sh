#!/bin/bash
# 05_google_dorks.sh
# Prints a structured set of Google Search operator ("dork") queries to test
# a target domain's search-engine indexing and exposure. Google has no public
# API for this without a paid key, so this script prints the queries for you
# to run manually in a browser rather than scraping results programmatically
# (scraping Google search results violates its Terms of Service).
#
# Usage: ./05_google_dorks.sh <target-domain> [company-domain-for-email-check]

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <target-domain> [company-domain-for-email-check]"
  exit 1
fi

DOMAIN="$1"
EMAIL_DOMAIN="${2:-$DOMAIN}"

echo "Run each of the following manually in a search engine:"
echo
echo "site:$DOMAIN"
echo "site:$DOMAIN filetype:pdf"
echo "site:$DOMAIN filetype:xml"
echo "site:$DOMAIN inurl:internal-portal"
echo "site:$DOMAIN inurl:admin"
echo "\"$EMAIL_DOMAIN\" \"@$EMAIL_DOMAIN\""
echo
echo "Also check the Wayback Machine for historical snapshots:"
echo "https://web.archive.org/web/*/$DOMAIN"
