#!/bin/bash
set -euo pipefail
source settings.sh

running="$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)"
if [ "${running}" != 'true' ]; then
  docker run -d --restart=always -p "${reg_port}:${reg_port}" --name "${reg_name}" registry:2
fi
