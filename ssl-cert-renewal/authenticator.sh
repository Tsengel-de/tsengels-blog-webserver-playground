#!/usr/bin/env bash

# Fixed Authenticator
ENV_FILE="/home/pi/tsengels-blog-webserver-playground/ssl-cert-renewal/env.txt"

set -a
. "$ENV_FILE"
set +a

# get the Ionos zone id
ZONE_RESPONSE=$(curl -s -X GET "$API_URL/zones" \
                     -H "X-API-Key: $API_KEY" \
                     -H "Accept: application/json")
ZONE_ID=$(echo "$ZONE_RESPONSE" | jq -r '.[0].id')

if [ -z "$ZONE_ID" ] || [ "$ZONE_ID" = "null" ]; then
    echo "ERROR: IONOS Auth failed. Response: $ZONE_RESPONSE"
    exit 1
fi

# Create TXT record
CREATE_DOMAIN="_acme-challenge.$CERTBOT_DOMAIN"
echo "Creating TXT record: $CREATE_DOMAIN = $CERTBOT_VALIDATION"
curl -s -X POST "$API_URL/zones/$ZONE_ID/records" \
      -H "X-API-Key: $API_KEY" \
      -H "Content-Type: application/json" \
      --data "[{\"name\": \"$CREATE_DOMAIN\", \"type\": \"TXT\", \"content\": \"$CERTBOT_VALIDATION\", \"ttl\": 60, \"prio\": 100, \"disabled\": false}]"

# Save zone ID for cleanup
echo "$ZONE_ID" > "/tmp/CERTBOT_$CERTBOT_DOMAIN"

# Sleep to allow DNS propagation
echo "Waiting 90 seconds for DNS propagation..."
sleep 90
