#!/bin/bash

TAG=$1

if ! [ -z $1 ]; then
# docker build --tag "registry.example.com:5000/vote_app:$TAG" vote/
# docker build --tag "registry.example.com:5000/worker_app:$TAG" worker/
# docker build --tag "registry.example.com:5000/result_app:$TAG" result/
# docker push "registry.example.com:5000/vote_app:$TAG"
# docker push "registry.example.com:5000/worker_app:$TAG"
# docker push "registry.example.com:5000/result_app:$TAG"
else
  echo "no TAG specified ./build.sh repo/name:tag.1"
fi
