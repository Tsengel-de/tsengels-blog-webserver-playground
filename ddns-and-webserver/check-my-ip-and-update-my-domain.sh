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
if [ $NEW_IP != $OLD_IP ];
  # when the ip is different update in intranet routing in Router mikrotik chateau 5g ax
  then
    CLUSTER_IP="192.168.88.150"
    ssh -i /home/tsengel/.ssh/tsengel_everywhere admin@$ROUTER_IP "/ip firewall nat add chain=dstnat action=dst-nat dst-address=$NEW_IP to-address=$WEBSERVER_IP protocol=tcp dst-port=443; /ip firewall nat add chain=srcnat action=masquerade dst-address=$WEBSERVER_IP src-address=$VLAN_RANGE protocol=tcp dst-port=443; /ip firewall nat add chain=dstnat action=dst-nat dst-address=$NEW_IP to-address=$CLUSTER_IP to-ports=443 protocol=tcp dst-port=8443"
  # then update IP by ionos DNS
  curl -X GET "https://ipv4.api.hosting.ionos.com/dns/v1/${DDNS_QUERY}"

  # Update *.homelab.tsengel.de via Ionos API (using IDs for stability)
  # Zone ID: c8487622-f7c2-11eb-9fc9-0a5864441a29
  # Record ID: efb444bb-4e71-9f2a-fc57-800930ddacfc
  curl -s -X PUT "$API_URL/zones/c8487622-f7c2-11eb-9fc9-0a5864441a29/records/efb444bb-4e71-9f2a-fc57-800930ddacfc" \
       -H "$API_KEY_HEADER" \
       -H "Content-Type: application/json" \
       --data '{"name": "*.homelab.tsengel.de", "type": "A", "content": "'"$NEW_IP"'", "ttl": 3600}'

  # update ip in ip.txt
  echo $NEW_IP > ip.txt
fi

