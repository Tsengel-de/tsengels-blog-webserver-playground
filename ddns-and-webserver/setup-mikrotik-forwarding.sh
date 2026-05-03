#!/bin/bash
# Setup MikroTik Port Forwarding & Hairpin NAT for Pi Cluster
# Purpose: Enable External (WAN) and Internal (WiFi) access to Cluster on Port 8443
# Target: 192.168.88.150:8443 (Which forwards to Ingress)

set -e

# Load credentials
if [ -f ../ssl-cert-renewal/env.txt ]; then
    set -a
    source ../ssl-cert-renewal/env.txt
    set +a
else
    echo "Warning: Credentials file not found. Ensure ROUTER_IP is set."
fi

CLUSTER_ENTRY="192.168.88.210"
CLUSTER_PORT="443"

echo "Configuring MikroTik router at $ROUTER_IP..."

# Commands to execute
commands=$(cat <<EOF
# 1. Clean old rules
/ip firewall nat remove [find comment="Pi-Cluster-HTTPS"]
/ip firewall nat remove [find comment="Hairpin-NAT-Cluster"]
/ip firewall filter remove [find comment="Allow-Cluster-8443"]

# 2. Port Forwarding (WAN Access)
/ip firewall nat add chain=dstnat action=dst-nat \
  protocol=tcp dst-port=$CLUSTER_PORT \
  to-address=$CLUSTER_ENTRY to-ports=$CLUSTER_PORT \
  comment="Pi-Cluster-HTTPS"

# 3. Hairpin NAT (Internal WiFi Access)
# Makes traffic from LAN -> LAN Public IP work correctly
/ip firewall nat add chain=srcnat src-address=192.168.88.0/24 \
  dst-address=$CLUSTER_ENTRY protocol=tcp dst-port=$CLUSTER_PORT \
  action=masquerade comment="Hairpin-NAT-Cluster"

# 4. Firewall Filter (Allow Traffic)
# Allow TCP 8443 through the firewall
/ip firewall filter add chain=forward protocol=tcp dst-port=$CLUSTER_PORT \
  action=accept comment="Allow-Cluster-8443" place-before=1

# 5. Verify
/ip firewall nat print where comment~"Cluster"
/ip firewall filter print where comment~"Cluster"
EOF
)

echo "Executing:"
echo "$commands"
echo "---------------------------------------------------"

# Execute via SSH
ssh -i /home/pi/.ssh/bachka_automation -o StrictHostKeyChecking=accept-new admin@$ROUTER_IP "$commands"
