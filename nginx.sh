#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

mkdir -p /mnt/cache/nginx/$name-b2
mkdir -p /mnt/cache/nginx/$name-rust

for file in $DIR/nginx/*.conf; do
  filename=$(basename $file)
  if [ -L "/etc/nginx/site/$filename" ] || [ -f "/etc/nginx/site/$filename" ]; then
    rm "/etc/nginx/site/$filename"
  fi
  ln -s "$file" "/etc/nginx/site/$filename"
done

nginx -t && nginx -s reload
