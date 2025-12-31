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
- **`setup-mikrotik-forwarding.sh`**:
    - **Purpose**: Configures MikroTik Router for Cluster Access (Port 8443).
    - **Features**: Sets up Destination NAT (WAN access), Hairpin NAT (WiFi access), and Firewall allow rules.
    - **Usage**: Run once to provision the router.

### 2. SSL Certificate Renewal (`ssl-cert-renewal/`)
This component manages SSL certificates using **Certbot** with DNS-01 validation.
- **`authenticator.sh`**: A Certbot manual authentication hook.
    - Finds the IONOS Zone ID for the domain.
    - Creates the `_acme-challenge` TXT record via the IONOS API.
    - Waits for propagation.
- **`cleanup.sh`**: A Certbot manual cleanup hook.
    - Removes the `_acme-challenge` TXT record after validation.
    - Uses both `jq` and `python` for JSON parsing.
    - Triggers a forced Certbot renewal.
    - Reloads **Nginx** upon success.
- **`sync-cluster-certs.sh`**:
    - **Purpose**: Copies renewed certificates to the **Pi Cluster** (Master Node `10.0.0.14`).
    - **Usage**: Run via Cron (e.g., weekly) or as a Certbot deploy hook.
    - **Requirements**: Needs passwordless SSH access (`ssh-copy-id tsengel@10.0.0.14`) and a static route to `10.0.0.0/24`.
        ```bash
        sudo ip route add 10.0.0.0/24 via 192.168.88.150
        ```

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