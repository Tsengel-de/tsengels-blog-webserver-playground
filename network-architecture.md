# Network Architecture

```mermaid
graph TB
    subgraph Internet
        Client[Client Browser]
        LetsEncrypt[Let's Encrypt CA]
        IONOS_DNS[IONOS DNS Server]
    end
    
    subgraph Home Network 192.168.88.x
        Router[Mikrotik Chateau 5G AX<br/>Router]
        RaspberryPi[Raspberry Pi<br/>192.168.88.123]
        
        subgraph Services on Pi
            Nginx[Nginx Web Server<br/>:443]
            Grav[Grav CMS<br/>/home/pi/www/grav]
            Certbot[Certbot SSL Manager]
            DDNSScript[DDNS Update Script<br/>check-my-ip-and-update-my-domain.sh]
        end
    end
    
    Client -->|HTTPS| Router
    Router -->|Port 443 NAT| Nginx
    Nginx --> Grav
    
    DDNSScript -->|1. Check WAN IP| OpenDNS[OpenDNSResolver]
    DDNSScript -->|2. Update NAT Rules| Router
    DDNSScript -->|3. Update DNS| IONOS_DNS
    
    Certbot -->|DNS-01 Challenge| LetsEncrypt
    Certbot -->|Create/Delete TXT Records| IONOS_DNS
    LetsEncrypt -->|Verify TXT Records| IONOS_DNS
    Certbot -->|Renew Certificate| Nginx
    
    style RaspberryPi fill:#1976d2,stroke:#0d47a1,stroke-width:2px,color:#fff
    style Router fill:#f57c00,stroke:#e65100,stroke-width:2px,color:#fff
    style Nginx fill:#388e3c,stroke:#1b5e20,stroke-width:2px,color:#fff
    style Certbot fill:#c2185b,stroke:#880e4f,stroke-width:2px,color:#fff
    style DDNSScript fill:#5e35b1,stroke:#311b92,stroke-width:2px,color:#fff
```

## Components

### External Services
- **Let's Encrypt CA**: Issues SSL/TLS certificates via DNS-01 challenge
- **IONOS DNS**: Authoritative DNS server and API for dynamic updates
- **OpenDNS**: Used to discover current WAN IP address

### Home Network
- **Mikrotik Router**: Handles NAT/Port Forwarding for HTTPS (443) traffic
- **Raspberry Pi** (`192.168.88.123`):
  - **Nginx**: Web server handling HTTPS requests
  - **Grav CMS**: Content management system
  - **Certbot**: Automated SSL certificate renewal
  - **DDNS Script**: Keeps DNS and NAT rules updated with current WAN IP

## Data Flow

### 1. Dynamic DNS Updates
1. Script queries OpenDNS to get current WAN IP
2. If IP changed: Update router NAT rules via SSH
3. Update IONOS DNS records via API
4. Store new IP for future comparisons

### 2. SSL Certificate Renewal
1. Certbot initiates renewal with Let's Encrypt
2. Certbot creates TXT record via IONOS API (`_acme-challenge`)
3. Let's Encrypt queries DNS to verify domain ownership
4. Certificate issued and Nginx reloaded
5. Certbot cleans up TXT record via IONOS API

### 3. Client Access
1. Client requests `https://yourdomain.com`
2. DNS resolves to current WAN IP (via IONOS)
3. Router forwards :443 to Raspberry Pi
4. Nginx serves content from Grav CMS
