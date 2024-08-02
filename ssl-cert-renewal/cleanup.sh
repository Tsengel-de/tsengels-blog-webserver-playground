#!/usr/bin/env bash

# activate log in cli
set -x

API_URL="https://api.hosting.ionos.com/dns/v1"
API_KEY_HEADER="X-API-Key: $API_KEY"

if [ -f /tmp/CERTBOT_$CERTBOT_DOMAIN ]; then
    ZONE_ID=$(cat /tmp/CERTBOT_$CERTBOT_DOMAIN)
    rm -f /tmp/CERTBOT_$CERTBOT_DOMAIN

    CREATE_DOMAIN="_acme-challenge.$CERTBOT_DOMAIN"
    # request the created records
    RECORD_GET_RESPONSE=$(curl -s -X GET "$API_URL/zones/$ZONE_ID?recordName=$CREATE_DOMAIN&recordType=TXT" \
                             -H "$API_KEY_HEADER" \
                             -H "Accept: application/json")
    RECORD_IDS=$(echo $RECORD_GET_RESPONSE \
            | python -c "import sys,json;records=json.load(sys.stdin)['records'];print('\n'.join([x['id'] for x in records]))")
fi