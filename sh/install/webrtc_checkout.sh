#!/usr/bin/env bash
# environment file for checkout libwebrtc project

cat << END > ./.gclient
solutions = [
  {
    "name": "src",
    "url": "https://github.com/aggresss/playground-libwebrtc.git",
    "deps_file": "DEPS",
    "managed": False,
    "custom_deps": {},
  },
]
END

