#!/bin/bash

set -e

docker build --no-cache --rm -t pochi-infra Dockerfiles/infra
docker build --no-cache --rm -t pochi-nginx Dockerfiles/nginx
docker build --no-cache --rm -t pochi-rails Dockerfiles/rails

docker-compose build;
