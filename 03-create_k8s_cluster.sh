#!/bin/bash

sudo chown -R vscode ~/.kube
sudo chgrp -R vscode ~/.kube

HOST_IP=`hostname -I | awk '{ print $1 ; exit }'`

set -euo pipefail
source settings.sh

kind_running="$(docker inspect -f '{{.State.Running}}' "example-control-plane" 2>/dev/null || true)"
if [ "${kind_running}" != 'true' ]; then
cat <<EOF | kind create cluster --name example --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  apiServerAddress: "${HOST_IP}"
nodes:
- role: control-plane
  image: ${reg_name}:${reg_port}/node:${KUBERNETES_REPO_COMMIT}
  extraMounts:
  - hostPath: /workspaces
    containerPath: /workspaces
  extraPortMappings:
  - containerPort: 30000
    hostPort: 9000
    # optional: set the bind address on the host
    # 0.0.0.0 is the current default
    #listenAddress: "127.0.0.1"
    # optional: set the protocol to one of TCP, UDP, SCTP.
    # TCP is the default
    protocol: TCP
containerdConfigPatches:
- |-
  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."localhost:${reg_port}"]
    endpoint = ["http://${reg_name}:${reg_port}"]
EOF

# make sure that the registry container and control plane can talk to each other
INPSECT_NETWORK=`docker network inspect kind`
if [[ "$INPSECT_NETWORK" == *"$reg_name"* ]]; then
echo "kind network contains ${reg_name} skipping adding"
fi

fi
