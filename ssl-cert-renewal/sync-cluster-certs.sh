#!/bin/bash

# sync-cluster-certs.sh
# Purpose: Sync Let's Encrypt certificates from this Webserver to the Pi Cluster
# Usage: Run this script via Cron (e.g., in /etc/letsencrypt/renewal-hooks/deploy/)

# Variables
CERT_DIR="/etc/letsencrypt/live/tsengel.de"
CLUSTER_USER="tsengel"     # User on the cluster node
CLUSTER_HOST="10.0.0.14"   # K3s Master Node IP (node4)
# Note: Ensure Webserver can reach 10.0.0.14 (Static Route or Jump Host)
KUBECTL_CMD="sudo k3s kubectl" # Command to run kubectl on the node

# Check if certs exist
if [[ ! -f "$CERT_DIR/fullchain.pem" || ! -f "$CERT_DIR/privkey.pem" ]]; then
    echo "Error: Certificates not found in $CERT_DIR"
    exit 1
fi

echo "Reading certificates..."
FULLCHAIN=$(base64 -w0 "$CERT_DIR/fullchain.pem")
PRIVKEY=$(base64 -w0 "$CERT_DIR/privkey.pem")

# Generate Kubernetes YAML for all namespaces
# We create a multi-doc YAML to update all secrets in one go
cat <<EOF > /tmp/cluster-secrets.yaml
apiVersion: v1
kind: Secret
metadata:
  name: vault-tls
  namespace: vault
type: kubernetes.io/tls
data:
  tls.crt: $FULLCHAIN
  tls.key: $PRIVKEY
---
apiVersion: v1
kind: Secret
metadata:
  name: longhorn-tls
  namespace: longhorn-system
type: kubernetes.io/tls
data:
  tls.crt: $FULLCHAIN
  tls.key: $PRIVKEY
---
apiVersion: v1
kind: Secret
metadata:
  name: monitoring-tls
  namespace: kube-prom-stack
type: kubernetes.io/tls
data:
  tls.crt: $FULLCHAIN
  tls.key: $PRIVKEY
---
apiVersion: v1
kind: Secret
metadata:
  name: monitoring-tls
  namespace: grafana
type: kubernetes.io/tls
data:
  tls.crt: $FULLCHAIN
  tls.key: $PRIVKEY
---
apiVersion: v1
kind: Secret
metadata:
  name: hubble-tls
  namespace: kube-system
type: kubernetes.io/tls
data:
  tls.crt: $FULLCHAIN
  tls.key: $PRIVKEY
---
apiVersion: v1
kind: Secret
metadata:
  name: minio-tls
  namespace: minio
type: kubernetes.io/tls
data:
  tls.crt: $FULLCHAIN
  tls.key: $PRIVKEY
---
apiVersion: v1
kind: Secret
metadata:
  name: minio-console-tls
  namespace: minio
type: kubernetes.io/tls
data:
  tls.crt: $FULLCHAIN
  tls.key: $PRIVKEY
EOF

echo "Pushing secrets to cluster ($CLUSTER_HOST)..."
# Copy the YAML to the cluster
scp /tmp/cluster-secrets.yaml "$CLUSTER_USER@$CLUSTER_HOST:/tmp/cluster-secrets.yaml"

# Apply the secrets and restart Ingress
ssh "$CLUSTER_USER@$CLUSTER_HOST" << 'ENDSSH'
    echo "Applying secrets..."
    sudo k3s kubectl apply -f /tmp/cluster-secrets.yaml
    
    echo "Restarting Ingress Controller to pick up new certs..."
    sudo k3s kubectl delete pod -n nginx -l app.kubernetes.io/name=ingress-nginx
ENDSSH

# Cleanup
rm /tmp/cluster-secrets.yaml

echo "Done! Cluster certificates updated."
