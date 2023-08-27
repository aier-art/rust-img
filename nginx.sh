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

if [ -n "$HOST_LI" ]; then
  SERVERS=""
  for host in $HOST_LI; do
    SERVERS="${SERVERS}server $host:5500 max_fails=3 fail_timeout=6s;\n"
  done

  sed -i "s|server 127.0.0.1:5500;|${SERVERS}|g" /etc/nginx/site/img-b2.conf
fi

cd /etc/nginx/site
rm -rf jpg.5ok.pw.conf
ln -s $DIR/nginx/jpg.5ok.pw.conf .
nginx -t && nginx -s reload
