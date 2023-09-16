#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*/*}
set -ex

os_type=$(uname)

ensure() {
  for pkg in "$@"; do
    if ! command -v $pkg &>/dev/null; then
      apt-get install -y $pkg
    fi
  done
}

ensure g++ cmake

# VER=0.8.2
#
# if [ ! -d "jpegxl-rs" ]; then
#   git clone --recursive --shallow-submodules --depth=1 https://github.com/inflation/jpegxl-rs.git
# fi

# cd jpegxl-rs/jpegxl-src/libjxl
if [ ! -d "libjxl" ]; then
  git clone --depth=1 https://github.com/libjxl/libjxl.git
fi
cd libjxl
git pull
git submodule update --init --recursive

./deps.sh && cmake . -DJPEGXL_ENABLE_BENCHMARK=false -DBUILD_TESTING=OFF && make -j $(nproc) && make install
rm CMakeCache.txt

cd $DIR
