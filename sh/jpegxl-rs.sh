#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*/*}
set -ex

os_type=$(uname)

source $DIR/sh/cflag.sh

# VER=0.8.2
#
# if [ ! -d "jpegxl-rs" ]; then
#   git clone --recursive --shallow-submodules --depth=1 https://github.com/inflation/jpegxl-rs.git
# fi

# cd jpegxl-rs/jpegxl-src/libjxl
git clone --depth=1 https://github.com/libjxl/libjxl.git
cd libjxl
git submodule update --init --recursive

./deps.sh && cmake . -DBUILD_TESTING=OFF && make -j $(nproc) && make install
rm CMakeCache.txt

cd $DIR
