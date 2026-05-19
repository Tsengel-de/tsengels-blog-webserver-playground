#!/bin/bash
# setup-nuc-ssh.sh
# Purpose: Generate SSH key on NUC and authorize it on MikroTik
# Uses the Gateway (192.168.88.150) to reach the NUC on its internal IP (10.0.0.31)

set -e

ROUTER_IP="192.168.88.1"
GATEWAY_IP="192.168.88.150"
GATEWAY_USER="root"
NUC_IP="10.0.0.31"
NUC_USER="tsengel"
NUC_KEY_PATH="/home/tsengel/.ssh/id_rsa"
LOCAL_KEY="~/.ssh/tsengel_everywhere"

# Use ProxyJump to reach the NUC behind the gateway
SSH_NUC="ssh -i $LOCAL_KEY -o StrictHostKeyChecking=accept-new -J $GATEWAY_USER@$GATEWAY_IP"

echo "1. Generating SSH key on NUC (via Gateway)..."
$SSH_NUC $NUC_USER@$NUC_IP \
  "if [ ! -f $NUC_KEY_PATH ]; then ssh-keygen -t rsa -b 4096 -N '' -f $NUC_KEY_PATH; fi"

echo "2. Fetching NUC public key..."
NUC_PUB_KEY=$($SSH_NUC $NUC_USER@$NUC_IP "cat ${NUC_KEY_PATH}.pub")
echo "NUC Public Key found."

echo "3. Uploading NUC public key to MikroTik..."
echo "$NUC_PUB_KEY" > nuc_to_router.pub
scp -i $LOCAL_KEY -o StrictHostKeyChecking=accept-new nuc_to_router.pub admin@$ROUTER_IP:nuc_to_router.pub

echo "4. Importing key into MikroTik admin user..."
ssh -i $LOCAL_KEY admin@$ROUTER_IP "/user ssh-keys import public-key-file=nuc_to_router.pub user=admin"

echo "5. Cleaning up..."
rm nuc_to_router.pub

echo "------------------------------------------------"
echo "✅ NUC SSH Key has been authorized on the Router."
echo "Testing connection from NUC to Router..."
# Note: NUC should be able to reach 192.168.88.1 directly via the Gateway's routing
$SSH_NUC $NUC_USER@$NUC_IP "ssh -o StrictHostKeyChecking=accept-new admin@$ROUTER_IP '/system identity print'"
