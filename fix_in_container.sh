#!/bin/sh
# Search in /config/www instead of /app/www/public
find /config/www -type l | while IFS= read -r f; do
    t=$(readlink "$f")
    if echo "$t" | grep -q "^/home/pi/www/grav/"; then
        nt=$(echo "$t" | sed "s|^/home/pi/www/grav/|/config/www/|")
        rm "$f"
        ln -s "$nt" "$f"
        echo "Fixed $f"
    fi
done
