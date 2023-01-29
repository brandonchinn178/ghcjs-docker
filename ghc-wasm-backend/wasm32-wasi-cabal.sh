#!/usr/bin/env sh

export CABAL_DIR="${CABAL_DIR:-${HOME}/.ghc-wasm32-wasi/.cabal}"

GHC_BUILD_DIR=/opt/ghc/_build/stage1

exec cabal \
  --with-compiler=${GHC_BUILD_DIR}/bin/wasm32-wasi-ghc \
  --with-hc-pkg=${GHC_BUILD_DIR}/bin/wasm32-wasi-ghc-pkg \
  --with-hsc2hs=${GHC_BUILD_DIR}/bin/wasm32-wasi-hsc2hs \
  "$@"
