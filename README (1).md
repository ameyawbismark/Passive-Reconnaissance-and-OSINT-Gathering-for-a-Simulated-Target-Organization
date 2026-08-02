# Passive Reconnaissance and OSINT Gathering for a Simulated Target Organization

## Overview
Organizations frequently and unknowingly expose meaningful information about their internal operations through channels that aren't obviously sensitive — DNS configuration, job postings, staff directories, and document metadata. This project designed and deployed a complete public-facing digital footprint for a simulated organization, Meridian Cove Logistics (MCL), and then applied a structured set of passive reconnaissance and OSINT techniques against it, using only freely available, industry-standard tools, to demonstrate what an attacker could learn before ever touching a production system.

**Course:** CY376 — Network Monitoring, Security and Auditing
**Track:** Red Team
**Author:** Ameyaw Sarpong Bismark — FCM.41.018.044.23

## Tools Used
- **nslookup / DNS resolution** — resolving hostnames and testing whether candidate subdomains exist at the DNS layer (queried via Google's public resolver, 8.8.8.8)
- **ipinfo.io reverse-IP/ASN lookup** — attributing resolved IPs to their owning Autonomous System and hosting provider
- **curl** — HTTP response header inspection (`-I`) and distinguishing DNS-level resolution from actual HTTP/TLS-level service availability
- **theHarvester 4.11.1** — automated OSINT aggregation and subdomain enumeration (free-tier sources only)
- **exiftool** — extracting embedded metadata from a publicly downloadable PDF
- **Google Search operators ("dorking")** — testing search-engine indexing and exposure of sensitive paths/file types
- **Internet Archive Wayback Machine** — checking for historical archived snapshots of the target

## Repository Structure
```
src/       - site build files for the simulated target (HTML/CSS/JS) and the PDF metadata-stamping script
configs/   - robots.txt, sitemap.xml, netlify configuration
scripts/   - reconnaissance commands/scripts used during testing
docs/      - final report (PDF)
evidence/  - terminal screenshots and captured tool output
```

## How to Run
The assessment followed this sequence (carried out from a Kali Linux workstation with internet access):

1. Design and deploy the simulated target's full public footprint (corporate site, customer portal page, `robots.txt`, `sitemap.xml`, downloadable PDF brochure) — hosted on Netlify's free static-hosting tier.
2. Run DNS resolution and reverse-IP/ASN lookups against the target hostname:
   `nslookup meridiancovelogistics.netlify.app 8.8.8.8` and `curl ipinfo.io/<resolved-ip>`
3. Capture and analyze HTTP response headers: `curl -I https://meridiancovelogistics.netlify.app/`
4. Run automated subdomain enumeration: `theHarvester -d meridiancovelogistics.netlify.app -b all`, then independently verify every candidate at the DNS layer (`nslookup`) and HTTP/TLS layer (`curl -I`).
5. Test search-engine indexing using a structured set of Google dork queries (e.g. `site:meridiancovelogistics.netlify.app filetype:pdf`).
6. Manually enumerate employee names, roles, and emails from the target's published staff directory.
7. Extract and analyze PDF metadata: `exiftool MCL_2025_Sustainability_Brochure.pdf`

## Key Screenshots / Evidence
See the `evidence/` folder for the full set of captured terminal output, including:
- DNS resolution and reverse-IP/ASN lookup output
- HTTP response header capture
- theHarvester full run (source-by-source) and subdomain candidate list
- DNS and TLS verification of candidate subdomains (the false-positive finding)
- PDF metadata extraction output

## Report
The full report PDF is in `docs/`.

## Notes
- Lab/simulated data only — the target organization (Meridian Cove Logistics) is entirely fictitious, built and hosted by the author on Netlify's free tier for this assessment. No real, non-consenting third-party organization, domain, or individual was tested, scanned, or referenced.
- All testing was strictly passive — no port scanning, exploitation, credential testing, or active probing was performed.
- All testing was conducted against instructor-approved, isolated, author-controlled environments only.
