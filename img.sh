#!/usr/bin/env bash

nc -z -w 1 127.0.0.1 7890 && export https_proxy=http://127.0.0.1:7890

PORT=5500 TO=https://xxai.eu.org/ RUST_BACKTRACE=short exec /opt/bin/img
