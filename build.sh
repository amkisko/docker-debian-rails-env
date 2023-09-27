#!/bin/bash

account="kiskolabs"
image_name="debian-rails-ruby"

function echo_and_run {
  echo "$@"
  eval "$@"
}

function build {
  echo "Building $1"
  ruby_version=$(echo $1 | sed -E 's/ruby-([0-9.]+)-node-[0-9.]+/\1/')
  node_version=$(echo $1 | sed -E 's/ruby-[0-9.]+-node-([0-9.]+)/\1/')
  echo_and_run "docker build . --tag $account/$image_name --no-cache --build-arg RUBY_VERSION=$ruby_version --build-arg NODE_VERSION=$node_version"
  echo_and_run "docker push $account/$image_name:$1"
}

if [ $# -eq 1 ]; then
  build $1
  exit 0
fi

while read -r line; do
  build $line
done < wanted_tags
