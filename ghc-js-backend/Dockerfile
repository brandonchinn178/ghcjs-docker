# --------------- Base image with ghcup --------------- #

FROM ubuntu:22.10 AS base

# install ghc
RUN apt-get update \
    && apt-get install -y \
        build-essential curl libffi-dev libffi8ubuntu1 libgmp-dev libgmp10 libncurses-dev libncurses5 libtinfo5 \
        libnuma-dev
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | BOOTSTRAP_HASKELL_NONINTERACTIVE=1 sh
ENV PATH=/root/.ghcup/bin:$PATH

# --------------- Build GHC with JS backend --------------- #

FROM base AS builder

ENV LANG=C.UTF-8

RUN apt-get update \
    && apt-get install -y \
        alex \
        autoconf \
        emscripten \
        happy \
        llvm \
    && true

WORKDIR /opt
RUN apt-get update \
    && apt-get install -y git \
    && git clone https://gitlab.haskell.org/ghc/ghc.git

WORKDIR /opt/ghc
ARG GHC_GIT_REF=master
RUN git checkout $GHC_GIT_REF
RUN git submodule update --init --recursive
RUN ./boot && emconfigure ./configure CC=/usr/bin/emcc LD=/usr/bin/emcc --target=js-unknown-ghcjs
ARG BUILD_ARGS=-j
RUN ./hadrian/build --flavour=quick --bignum=native --docs=none $BUILD_ARGS

# --------------- Runtime image with ghcup + GHCJS installed --------------- #

FROM base

COPY --from=builder /opt/ghc /opt/ghc

RUN mkdir -p /usr/lib/ghcjs/bin/
RUN ln -sf /opt/ghc/_build/stage1/bin/js-unknown-ghcjs-ghc /usr/lib/ghcjs/bin/ghc
RUN ln -sf /opt/ghc/_build/stage1/bin/js-unknown-ghcjs-ghc-pkg /usr/lib/ghcjs/bin/ghc-pkg
RUN ln -sf /opt/ghc/_build/stage1/bin/js-unknown-ghcjs-hp2ps /usr/lib/ghcjs/bin/hp2ps
RUN ln -sf /opt/ghc/_build/stage1/bin/js-unknown-ghcjs-hsc2hs /usr/lib/ghcjs/bin/hsc2hs

RUN ln -sf /usr/lib/ghcjs/bin/ghc /usr/local/bin/ghcjs
ENTRYPOINT ["ghcjs"]
