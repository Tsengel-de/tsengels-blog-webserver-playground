#!/usr/bin/env bash

# Fixed Cleanup
ENV_FILE="/home/pi/tsengels-blog-webserver-playground/ssl-cert-renewal/env.txt"

set -a
. "$ENV_FILE"
set +a

if [ -f "/tmp/CERTBOT_$CERTBOT_DOMAIN" ]; then
    ZONE_ID=$(cat "/tmp/CERTBOT_$CERTBOT_DOMAIN")
    rm -f "/tmp/CERTBOT_$CERTBOT_DOMAIN"

    CREATE_DOMAIN="_acme-challenge.$CERTBOT_DOMAIN"

    # Get all matching TXT record IDs using jq
    RECORD_IDS=$(curl -s -X GET "$API_URL/zones/$ZONE_ID?recordName=$CREATE_DOMAIN&recordType=TXT" \
                 -H "X-API-Key: $API_KEY" \
                 -H "Accept: application/json" | jq -r '.records[].id')

    # Delete each record
    if [ -n "$RECORD_IDS" ] && [ "$RECORD_IDS" != "null" ]; then
        echo "$RECORD_IDS" | while read -r RECORD_ID; do
            echo "Deleting TXT record: $RECORD_ID"
            curl -s -X DELETE "$API_URL/zones/$ZONE_ID/records/$RECORD_ID" \
                 -H "X-API-Key: $API_KEY"
        done
    else
        echo "No TXT records to clean up"
    fi
fi