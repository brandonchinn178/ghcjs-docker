# GHC with WASM backend

This directory contains a Dockerfile for building a Docker image with GHC built with the new Javascript backend.

## Usage

```bash
docker pull brandonchinn178/ghc-wasm-backend

echo 'main = putStrLn "Hello world!"' > HelloWorld.hs
docker run --rm -v $PWD:/src brandonchinn178/ghc-wasm-backend /src/HelloWorld.hs

# install wasmtime
curl https://wasmtime.dev/install.sh -sSf | bash
wasmtime HelloWorld.wasm
```

The image also contains `wasm32-wasi-cabal` on PATH, which is configured to build with `wasm32-wasi-ghc`.

## Build

```bash
GHC_GIT_REF='<commit>' ./build.sh
```

See `build.sh` for other available arguments that can be set.
