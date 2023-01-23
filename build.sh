#!/usr/bin/env sh

: ${GHC_GIT_REF:=master}

# space separated args to add to the `hadrian/build` command
: ${BUILD_ARGS:=-j}

docker build \
    -t brandonchinn178/ghc-js-backend:${GHC_GIT_REF} \
    --build-arg GHC_GIT_REF \
    --build-arg BUILD_ARGS \
    .
