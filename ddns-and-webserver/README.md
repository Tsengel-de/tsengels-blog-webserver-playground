# Project Summary: tsengels-blog-webserver-playground

This project is a collection of automation scripts designed to maintain a home web server, specifically handling Dynamic DNS (DDNS) updates and SSL certificate renewals via the IONOS API.

## Key Components

### 1. DDNS & Network Configuration (`ddns-and-webserver/`)
This component ensures the home network is accessible and correctly routed.
- **`check-my-ip-and-update-my-domain.sh`**:
    - **Wan IP Check**: Queries OpenDNS to find the current external IP.
    - **Router Configuration**: Connects to a **Mikrotik Chateau 5g ax** router via SSH to update NAT/Port Forwarding rules (Port 443) to the webserver.
    - **DNS Update**: Updates the DNS recordat **IONOS** via their API.
    - **State Tracking**: Stores the current IP in `ip.txt` to avoid unnecessary updates.

### 2. SSL Certificate Renewal (`ssl-cert-renewal/`)
This component manages SSL certificates using **Certbot** with DNS-01 validation.
- **`authenticator.sh`**: A Certbot manual authentication hook.
    - Finds the IONOS Zone ID for the domain.
    - Creates the `_acme-challenge` TXT record via the IONOS API.
    - Waits for propagation.
- **`cleanup.sh`**: A Certbot manual cleanup hook.
    - Removes the `_acme-challenge` TXT record after validation.
    - Uses both `jq` and `python` for JSON parsing.
- **`certbot_force_renewal.sh`**:
    - Triggers a forced Certbot renewal.
    - Reloads **Nginx** upon success.

## Technology Stack & Dependencies

- **Shell**: Bash scripts are the primary drivers.
- **Networking**: `dig` (dnsutils), `curl`, `ssh`.
- **Data Processing**: `jq` (JSON processor), `python` (used in cleanup script).
- **Services**:
    - **IONOS API**: For DNS management.
    - **Mikrotik RouterOS**: For local network routing.
    - **Certbot**: For Let's Encrypt certificates.
    - **Nginx**: The web server being managed.

## Verified Deployment
Confirmed working on production server `192.168.88.123` with user `pi`.

## Network Architecture
See [Network Architecture](../network-architecture.md) for a visual overview.