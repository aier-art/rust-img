#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

direnv allow
./sh/jpegxl-rs.sh
./dist.native.sh
./install.img.service.sh
rm -rf jpegxl-rs
