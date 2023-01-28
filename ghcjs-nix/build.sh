#!/usr/bin/env sh

HERE="$(builtin cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

docker build \
    -t brandonchinn178/ghcjs-nix \
    "${HERE}"
