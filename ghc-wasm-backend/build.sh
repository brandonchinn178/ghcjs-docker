#!/usr/bin/env sh

HERE="$(builtin cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -z "${GHC_GIT_REF:-}" ]]; then
    echo "GHC_GIT_REF needs to be set" >&2
    exit 1
fi

# space separated args to add to the `hadrian/build` command
: ${BUILD_ARGS:=-j}

docker build \
    -t brandonchinn178/ghc-wasm-backend:${GHC_GIT_REF} \
    --build-arg GHC_GIT_REF \
    --build-arg BUILD_ARGS \
    "${HERE}"
