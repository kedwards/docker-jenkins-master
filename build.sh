#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# enable interruption signal handling
trap - INT TERM

SCRIPT_DIR=$(dirname $(readlink -f "$0"))
IMAGE_VERSION=0.1.0
NAME=$1
DOCKERFILE=$2

docker build --no-cache -t kevinedwards/${NAME}:${IMAGE_VERSION} ${SCRIPT_DIR}

docker image tag "kevinedwards/${NAME}:${IMAGE_VERSION}" "kevinedwards/${NAME}:latest"

