#!/usr/bin/env bash

nc -z -w 1 127.0.0.1 7890 && export https_proxy=http://127.0.0.1:7890

TO="https://f004.backblazeb2.com/file/xxai-jxl/" RUST_BACKTRACE=short exec /usr/local/bin/img
