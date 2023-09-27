#!/bin/bash

account="kiskolabs"
image_name="debian-rails-ruby"

function echo_and_run {
  echo "$@"
  eval "$@"
}

function build {
  if [[ ! "$1" =~ ^ruby-[0-9.]+-node-[0-9.]+$ ]]; then
    echo "Ignoring $1"
    return
  fi
  ruby_version=$(echo $1 | sed -E 's/ruby-([0-9.]+)-node-[0-9.]+/\1/')
  node_version=$(echo $1 | sed -E 's/ruby-[0-9.]+-node-([0-9.]+)/\1/')
  echo "Building ruby $ruby_version with node $node_version to $account/$image_name:$1"
  if [ -z "$ruby_version" ]; then
    echo "Could not parse ruby version from $1"
    exit 1
  fi
  if [ -z "$node_version" ]; then
    echo "Could not parse node version from $1"
    exit 1
  fi
  echo_and_run "docker build . --tag $account/$image_name:$1 --no-cache --build-arg RUBY_VERSION=$ruby_version --build-arg NODE_VERSION=$node_version"
  echo_and_run "docker push $account/$image_name:$1"
}

if [ $# -eq 1 ]; then
  build "$1"
  exit 0
fi

while read -r line; do
  build "$line"
done < wanted_tags
