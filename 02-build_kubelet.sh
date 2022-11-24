#!/bin/bash
set -euo pipefail
source settings.sh

docker build -ti ${image_name} custom-kubelet
docker push ${image_name}
