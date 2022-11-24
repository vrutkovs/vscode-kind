#!/bin/bash
set -euo pipefail
source settings.sh

docker build -t ${image_name} -f custom-kubelet/Dockerfile custom-kubelet
docker push ${image_name}
