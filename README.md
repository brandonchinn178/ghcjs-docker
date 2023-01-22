# GHC with JS backend

This repo contains a Dockerfile for building a Docker image with GHC built with the new Javascript backend.

## Usage

```bash
docker pull brandonchinn178/ghc-js-backend

echo 'main = putStrLn "Hello world!"' > HelloWorld.hs
docker run --rm -it -v $PWD:/src brandonchinn178/ghc-js-backend /src/HelloWorld.hs
./HelloWorld
```

Note: currently does not work: https://gitlab.haskell.org/ghc/ghc/-/issues/22814

## Build

```bash
./build.sh

GHC_GIT_REF='<commit>' ./build.sh
```
