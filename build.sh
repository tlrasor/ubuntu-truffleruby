#!/usr/bin/env bash

set -e

UBUNTU_VERSION="18.04"
TRUFFLERUBY_VERSION="19.2.0.1"

BUILD_ARGS="--build-arg ubuntu_version=${UBUNTU_VERSION} --build-arg truffleruby_version=truffleruby-${TRUFFLERUBY_VERSION}"
TAG="tlrasor/ubuntu-truffleruby"

echo "Building"

docker build ${BUILD_ARGS} -t ${TAG} .

echo "Tagging"

docker tag ${TAG}:latest ${TAG}:${TRUFFLERUBY_VERSION}

echo "Bagging"

if [ ! -z "$NO_PUSH" ]; then
    echo "Skipping release!"
else
    docker push ${TAG}:${TRUFFLERUBY_VERSION}
fi

echo "done!"