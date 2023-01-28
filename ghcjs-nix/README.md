# GHCJS

This directory contains a Dockerfile for building a Docker image with GHCJS via Nix.

## Usage

```bash
docker pull brandonchinn178/ghcjs-nix

echo 'main = putStrLn "Hello world!"' > HelloWorld.hs
docker run --rm -v $PWD:/src brandonchinn178/ghcjs-nix /src/HelloWorld.hs
node ./HelloWorld
```

## Build

```bash
./build.sh
```
