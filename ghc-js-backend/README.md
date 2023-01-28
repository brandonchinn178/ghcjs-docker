# GHC with JS backend

This directory contains a Dockerfile for building a Docker image with GHC built with the new Javascript backend.

## Usage

```bash
docker pull brandonchinn178/ghc-js-backend

echo 'main = putStrLn "Hello world!"' > HelloWorld.hs
docker run --rm -v $PWD:/src brandonchinn178/ghc-js-backend /src/HelloWorld.hs
./HelloWorld
```

## Build

```bash
./build.sh

GHC_GIT_REF='<commit>' ./build.sh
```

See `build.sh` for other available arguments that can be set.
