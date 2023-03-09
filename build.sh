#!/bin/bash

account="amkisko"

function build {
  docker build $1/. --tag $account/$1
  docker push $account/$1:latest
}

for dir in */; do
  if [ -d "$dir" ]; then
    build "${dir%/}"
  fi
done

