#!/bin/bash
set -euo pipefail
source settings.sh

docker build --build-arg KUBERNETES_REPO="${KUBERNETES_REPO}" --build-arg KUBERNETES_REPO_COMMIT="${KUBERNETES_REPO_COMMIT}" -t "${local_image_name}" -f custom-kubelet/Dockerfile custom-kubelet
docker push "${local_image_name}"
