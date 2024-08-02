#!/usr/bin/env bash

# activate log in cli
set -x

set -a
. ./env.txt
set +a

sudo apt install jq

# strip only the top domain to get the zone id
ZONE_NAME=$(expr match "$CERTBOT_DOMAIN" '.*\.\(.*\..*\)')

# when already the top level domain then use it
if [ -z "$ZONE_NAME" ]; then
  ZONE_NAME="$CERTBOT_DOMAIN"
fi

# get the Ionos zone id
ZONE_RESPONSE=$(curl -s -X GET "$API_URL/zones" \
                     -H "$API_KEY_HEADER" \
                     -H "Accept: application/json")
ZONE_ID=$(echo $ZONE_RESPONSE | jq -r .[].id)