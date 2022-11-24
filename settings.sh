#/bin/bash

reg_name='kind-registry'
reg_port='5000'

KUBERNETES_REPO="https://github.com/vrutkovs/kubernetes"
KUBERNETES_REPO_COMMIT="872e5269135"
image_name="${reg_name}:${reg_port}/node:${KUBERNETES_REPO_COMMIT}"
