#!/usr/bin/env sh

: ${GHC_GIT_REF:=master}
docker build \
    -t brandonchinn178/ghc-js-backend:${GHC_GIT_REF} \
    --build-arg GHC_GIT_REF \
    .
