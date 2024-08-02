#!/usr/bin/env bash

# activate log in cli
set -x

API_URL="https://api.hosting.ionos.com/dns/v1"
API_KEY_HEADER="X-API-Key: $API_KEY"

if [ -f /tmp/CERTBOT_$CERTBOT_DOMAIN ]; then
    ZONE_ID=$(cat /tmp/CERTBOT_$CERTBOT_DOMAIN)
    rm -f /tmp/CERTBOT_$CERTBOT_DOMAIN
fi