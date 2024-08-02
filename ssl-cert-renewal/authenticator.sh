#!/usr/bin/env bash

# activate log in cli
set -x

set -a
. ./env.txt
set +a

# strip only the top domain to get the zone id
ZONE_NAME=$(expr match "$CERTBOT_DOMAIN" '.*\.\(.*\..*\)')

# when already the top level domain then use it
if [ -z "$ZONE_NAME" ]; then
  ZONE_NAME="$CERTBOT_DOMAIN"
fi