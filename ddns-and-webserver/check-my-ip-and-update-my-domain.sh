#!/usr/bin/env bash

# we need to install dnsutils for checking our wan ip
# sudo apt install dnsutils
set -x
# your ssh-pub-key must be added in your router settings

# read file and export environment variables
set -a
. ../ssl-cert-renewal/env.txt
set +a

# old ip written in ip.txt
OLD_IP=$(cat ip.txt)
# check to get your wan-ip
NEW_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)

# compare the IPs
if [ "$NEW_IP" != "$OLD_IP" ]; then
    CLUSTER_IP="192.168.88.150"
    ssh -i /home/tsengel/.ssh/tsengel_everywhere admin@$ROUTER_IP "/ip firewall nat add chain=dstnat action=dst-nat dst-address=$NEW_IP to-address=$WEBSERVER_IP protocol=tcp dst-port=443; /ip firewall nat add chain=srcnat action=masquerade dst-address=$WEBSERVER_IP src-address=$VLAN_RANGE protocol=tcp dst-port=443; /ip firewall nat add chain=dstnat action=dst-nat dst-address=$NEW_IP to-address=$CLUSTER_IP to-ports=443 protocol=tcp dst-port=8443"

    # ------------------------------------------------------------------
    # IONOS DNS API UPDATES
    # ------------------------------------------------------------------
    # We use specific Record IDs to update ONLY the desired domains.
    # The Zone ID is hardcoded for tsengel.de
    ZONE_ID="c8487622-f7c2-11eb-9fc9-0a5864441a29"

    # 1. Update *.homelab.tsengel.de
    curl -s -X PUT "$API_URL/zones/$ZONE_ID/records/efb444bb-4e71-9f2a-fc57-800930ddacfc" \
         -H "$API_KEY_HEADER" \
         -H "Content-Type: application/json" \
         --data '{"name": "*.homelab.tsengel.de", "type": "A", "content": "'"$NEW_IP"'", "ttl": 3600}'

    # 2. Update blog.tsengel.de (ID: d9dcf431-bf54-53e2-8c33-2eaf174fb32b)
    curl -s -X PUT "$API_URL/zones/$ZONE_ID/records/d9dcf431-bf54-53e2-8c33-2eaf174fb32b" \
         -H "$API_KEY_HEADER" \
         -H "Content-Type: application/json" \
         --data '{"name": "blog.tsengel.de", "type": "A", "content": "'"$NEW_IP"'", "ttl": 3600}'

    # 3. Update www.blog.tsengel.de (ID: f8265fa0-7f78-ac66-5577-7af1f36e1eee)
    curl -s -X PUT "$API_URL/zones/$ZONE_ID/records/f8265fa0-7f78-ac66-5577-7af1f36e1eee" \
         -H "$API_KEY_HEADER" \
         -H "Content-Type: application/json" \
         --data '{"name": "www.blog.tsengel.de", "type": "A", "content": "'"$NEW_IP"'", "ttl": 3600}'

    # 4. Update www.tsengel.de (ID: d07fd6e0-869d-348e-57c3-b204e2ed2b5e)
    curl -s -X PUT "$API_URL/zones/$ZONE_ID/records/d07fd6e0-869d-348e-57c3-b204e2ed2b5e" \
         -H "$API_KEY_HEADER" \
         -H "Content-Type: application/json" \
         --data '{"name": "www.tsengel.de", "type": "A", "content": "'"$NEW_IP"'", "ttl": 3600}'

    # 5. Update tsengel.de (Root @) (ID: 651a4bb3-2283-fc22-7e56-9b9f82a17034)
    curl -s -X PUT "$API_URL/zones/$ZONE_ID/records/651a4bb3-2283-fc22-7e56-9b9f82a17034" \
         -H "$API_KEY_HEADER" \
         -H "Content-Type: application/json" \
         --data '{"name": "tsengel.de", "type": "A", "content": "'"$NEW_IP"'", "ttl": 3600}'

    # update ip in ip.txt
    echo $NEW_IP > ip.txt
fi
