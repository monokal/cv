#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

set -x
docker build -f Dockerfile -t monokal/cv:latest .
docker push monokal/cv:latest
