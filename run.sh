#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

cargo build

TO=https://user0.gq/ \
  RUST_BACKTRACE=short \
  exec ${1:-./target/debug/img}
