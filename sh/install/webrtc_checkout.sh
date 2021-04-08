#!/usr/bin/env bash
# environment file for checkout libwebrtc project

cat << END > ./.gclient
solutions = [
  {
    "name": "src",
    "url": "https://github.com/aggresss/libwebrtc.git@M89",
    "deps_file": "DEPS",
    "managed": False,
    "custom_deps": {},
  },
]
END

