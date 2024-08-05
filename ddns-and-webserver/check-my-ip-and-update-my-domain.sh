#!/usr/bin/env bash

# we need to install dnsutils for checking our wan ip
# sudo apt install dnsutils

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
  then ssh -i /opt/minion/minion admin@$ROUTER_IP "/ip firewall nat add chain=dstnat action=dst-nat dst-address=$NEW_IP to-address=$WEBSERVER_IP protocol=tcp dst-port=443; /ip firewall nat add chain=srcnat action=masquerade dst-address=$WEBSERVER_IP src-address=$VLAN_RANGE protocol=tcp dst-port=443"
  # then update IP by ionos DNS
  curl -X GET "https://ipv4.api.hosting.ionos.com/dns/v1/${DDNS_QUERY}"
  # update ip in ip.txt
  echo $NEW_IP > ip.txt
fi

