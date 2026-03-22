#!/usr/bin/env bash
# add-client.sh: Automate adding Wireguard Peer on MikroTik & build safe config template
# Usage: ./add-client.sh <client_name> <client_public_key> <vpn_internal_ip>

set -e

CLIENT_NAME=$1
PUB_KEY=$2
VPN_INTERNAL_IP=$3  # This is the VIRTUAL IP inside the tunnel (e.g., 10.0.8.3)

if [ -z "$CLIENT_NAME" ] || [ -z "$PUB_KEY" ] || [ -z "$VPN_INTERNAL_IP" ]; then
    echo "Usage: $0 <client_name> <client_public_key> <vpn_internal_ip>"
    echo "Example: $0 work-laptop \"lfIcbSD...\" 10.0.8.3"
    exit 1
fi

ROUTER_IP="192.168.88.1"
ROUTER_PUB_KEY="0CVFhXtS38yWMFynMmKfsmKt7HvMi0RLIXf1Y5w/ISk="
SSH_KEY="/home/bachka/.ssh/tsengel_everywhere"

echo "➡️ Adding Peer '$CLIENT_NAME' onto MikroTik for Virtual IP $VPN_INTERNAL_IP..."

# 1. Add peer configuration on MikroTik via SSH
ssh -i "$SSH_KEY" -o StrictHostKeyChecking=no admin@"$ROUTER_IP" "
/interface wireguard peers add interface=wireguard-vpn public-key=\"$PUB_KEY\" allowed-address=\"$VPN_INTERNAL_IP/32\" comment=\"$CLIENT_NAME\"
"

# 2. Create local client directory
CLIENT_DIR="clients/$CLIENT_NAME"
mkdir -p "$CLIENT_DIR"

# 3. Generate the client configuration file
cat <<EOF > "$CLIENT_DIR/wg0.conf"
[Interface]
PrivateKey = [NEW_USER_PRIVATE_KEY]  # From client app
Address = $VPN_INTERNAL_IP/24

[Peer]
PublicKey = $ROUTER_PUB_KEY
Endpoint = vpn.tsengel.de:13231
AllowedIPs = 192.168.88.0/24
PersistentKeepalive = 25
EOF

echo "✅ Success!"
echo "Client file template created: $CLIENT_DIR/wg0.conf"
