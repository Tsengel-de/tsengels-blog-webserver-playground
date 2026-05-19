#!/bin/bash
# Setup MikroTik Port Forwarding & Hairpin NAT for Pi Cluster
# Purpose: Enable External (WAN) and Internal (WiFi) access to Cluster on Port 443

set -e

# Load credentials
if [ -f ../ssl-cert-renewal/env.txt ]; then
    set -a
    source ../ssl-cert-renewal/env.txt
    set +a
else
    echo "Warning: Credentials file not found. Ensure ROUTER_IP is set."
fi

CLUSTER_ENTRY="192.168.88.248"
CLUSTER_IPV6="2a01:598:d08e:32b9:14b2:2558:265a:43ad"
CLUSTER_PORT="443"

# Detect SSH key based on where we are running
if [ "$(hostname)" == "node-nuc-1" ]; then
    SSH_KEY="$HOME/.ssh/id_rsa"
    echo "Running on NUC, using local key: $SSH_KEY"
else
    SSH_KEY="$HOME/.ssh/tsengel_everywhere"
    echo "Running on Gaming PC, using key: $SSH_KEY"
fi

echo "Configuring MikroTik router at $ROUTER_IP..."

# Commands to execute
commands=$(cat <<EOF
/ip firewall nat remove [find comment~"Cluster"]
/ip firewall filter remove [find comment~"Cluster"]
/ipv6 firewall filter remove [find comment~"Cluster"]
/ipv6 firewall address-list remove [find comment~"Cluster"]

/ip firewall nat add chain=dstnat action=dst-nat protocol=tcp dst-port=$CLUSTER_PORT in-interface-list=WAN to-addresses=$CLUSTER_ENTRY to-ports=$CLUSTER_PORT comment="Pi-Cluster-HTTPS-WAN"
/ip firewall nat add chain=dstnat action=dst-nat protocol=tcp dst-port=$CLUSTER_PORT in-interface-list=LAN dst-address-type=local to-addresses=$CLUSTER_ENTRY to-ports=$CLUSTER_PORT comment="Pi-Cluster-HTTPS-Hairpin-DST"
/ip firewall nat add chain=srcnat action=masquerade protocol=tcp dst-port=$CLUSTER_PORT src-address=192.168.88.0/24 dst-address=$CLUSTER_ENTRY comment="Pi-Cluster-HTTPS-Hairpin-SRC"

/ipv6 firewall address-list add list=cluster-ingress address=$CLUSTER_IPV6 comment="Pi-Cluster-Ingress"
/ipv6 firewall filter add chain=forward action=accept protocol=tcp dst-port=443 dst-address-list=cluster-ingress comment="Allow-Cluster-HTTPS-v6" place-before=0
/ipv6 firewall filter add chain=forward action=accept protocol=tcp dst-port=80 dst-address-list=cluster-ingress comment="Allow-Cluster-HTTP-v6" place-before=0

/ip firewall filter add chain=forward protocol=tcp dst-port=$CLUSTER_PORT action=accept comment="Allow-Cluster-443" place-before=1

/ip firewall nat print where comment~"Cluster"
/ip firewall filter print where comment~"Cluster"
/ipv6 firewall filter print where comment~"Cluster"
EOF
)

# Execute via SSH
ssh -i "$SSH_KEY" -o StrictHostKeyChecking=accept-new admin@$ROUTER_IP "$commands"
