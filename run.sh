#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

cargo build

TO=https://xxai.eu.org/ \
  RUST_BACKTRACE=short \
  exec ${1:-./target/debug/img}
