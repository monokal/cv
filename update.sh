#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

set -x
docker build -f Dockerfile.build -t monokal/cv:latest .
docker run --rm monokal/cv:build cat cv > cv
chmod +x cv
