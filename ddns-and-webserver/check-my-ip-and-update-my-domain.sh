#!/usr/bin/env bash

# check-my-ip-and-update-my-domain.sh
# Purpose: Update IONOS DNS AAAA records for the Pi Cluster (IPv6 Migration)
# and update MikroTik firewall rules.

set -x

# 1. Load credentials
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
set -a
if [ -f "$DIR/../ssl-cert-renewal/env.txt" ]; then
    . "$DIR/../ssl-cert-renewal/env.txt"
elif [ -f "$DIR/env.txt" ]; then
    . "$DIR/env.txt"
fi
set +a

# Configuration
NUC_INTERNAL_IP="192.168.88.248"
ZONE_ID="c8487622-f7c2-11eb-9fc9-0a5864441a29"
# Use pi's key or default identity
if [ -f "/home/pi/.ssh/id_ed25519" ]; then
    SSH_KEY="/home/pi/.ssh/id_ed25519"
elif [ -f "/home/pi/.ssh/tsengel_everywhere" ]; then
    SSH_KEY="/home/pi/.ssh/tsengel_everywhere"
else
    SSH_KEY="$HOME/.ssh/tsengel_everywhere"
fi

# 2. Get Current IPv6 of NUC (Stable)
# We prefer the public global address (2a01:598::)
NEW_IPV6=$(ssh -i "$SSH_KEY" -o StrictHostKeyChecking=accept-new tsengel@$NUC_INTERNAL_IP "ip -6 addr show scope global | grep -v temporary | grep -oP '(?<=inet6 )[^/]+' | grep '2a01:598' | head -n1")

if [ -z "$NEW_IPV6" ]; then
    NEW_IPV6=$(ssh -i "$SSH_KEY" -o StrictHostKeyChecking=accept-new tsengel@$NUC_INTERNAL_IP "ip -6 addr show scope global | grep -v temporary | grep -oP '(?<=inet6 )[^/]+' | head -n1")
fi

if [ -z "$NEW_IPV6" ]; then
    echo "Error: Could not determine NUC IPv6 address."
    exit 1
fi

# 3. Check for IP change
OLD_IPV6=""
if [ -f "$DIR/ipv6.txt" ]; then
    OLD_IPV6=$(cat "$DIR/ipv6.txt")
fi

if [ "$NEW_IPV6" != "$OLD_IPV6" ]; then
    echo "IPv6 changed from $OLD_IPV6 to $NEW_IPV6. Updating..."

    # 4. Update IONOS AAAA Records
    # IDs from manual check (2026-05-04)
    declare -A RECORDS=(
        ["tsengel.de"]="7168c91d-0ec5-faa5-5c1c-9f1ae15a61ad"
        ["www.tsengel.de"]="e68813e7-5eab-a4af-ae42-358ef4ab6e8b"
        ["blog.tsengel.de"]="0f618a13-895e-e7bb-7041-f8b092e1a250"
        ["www.blog.tsengel.de"]="d5b58f2f-0e2f-a4dc-60f3-8dc6953502f6"
        ["*.homelab.tsengel.de"]="25f4757f-3c09-582f-c653-d7ef67bfe02f"
    )

    for name in "${!RECORDS[@]}"; do
        id="${RECORDS[$name]}"
        echo "Updating AAAA for $name ($id)..."
        curl -s -X PUT "$API_URL/zones/$ZONE_ID/records/$id" \
             -H "$API_KEY_HEADER" \
             -H "Content-Type: application/json" \
             --data "{\"name\": \"$name\", \"type\": \"AAAA\", \"content\": \"$NEW_IPV6\", \"ttl\": 3600}"
    done

    # 5. Update MikroTik Address List
    echo "Updating MikroTik Address List..."
    ssh -i "$SSH_KEY" -o StrictHostKeyChecking=accept-new admin@$ROUTER_IP \
        "/ipv6 firewall address-list remove [find list=cluster-ingress]; /ipv6 firewall address-list add list=cluster-ingress address=$NEW_IPV6 comment=\"Pi-Cluster-Ingress\""

    # 6. Save new IP
    echo "$NEW_IPV6" > "$DIR/ipv6.txt"
    echo "Update complete."
else
    echo "IPv6 has not changed."
fi

# 7. (Optional) Legacy IPv4 Check - DISABLED as per request to move to IPv6
# NEW_IPV4=$(curl -s -4 ifconfig.me || echo "")
# OLD_IPV4=""
# if [ -f "$DIR/ip.txt" ]; then OLD_IPV4=$(cat "$DIR/ip.txt"); fi
# 
# if [ -n "$NEW_IPV4" ] && [ "$NEW_IPV4" != "$OLD_IPV4" ]; then
#     echo "IPv4 changed to $NEW_IPV4. (Legacy updates disabled)"
#     echo "$NEW_IPV4" > "$DIR/ip.txt"
# fi
