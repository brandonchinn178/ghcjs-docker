FROM haskell:9.4.4-slim

# ENV LANG=C.UTF-8

# # install GHC for bootstrapping
# RUN apt-get update \
#     && apt-get install -y \
#         build-essential curl libffi-dev libffi8ubuntu1 libgmp-dev libgmp10 libncurses-dev libncurses5 libtinfo5 \
#         libnuma-dev
# RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | \
#     BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
#     sh
# ENV PATH=/root/.ghcup/bin:$PATH

# set up ~/.ghc-wasm
RUN mkdir -p ~/.ghc-wasm
COPY env.sh /root/.ghc-wasm/env

# install wasi-sdk
ARG TARGETARCH
RUN mkdir -p /tmp/wasi-sdk && cd /tmp/wasi-sdk \
    && apt-get update && apt-get install -y curl jq unzip \
    && case $TARGETARCH in (amd64) JOB=x86_64-linux ;; (arm64) JOB=aarch64-linux ;; (*) echo "Unknown arch: $TARGETARCH" ;; esac \
    && ARTIFACT_URL=$(curl https://gitlab.haskell.org/api/graphql \
        -H 'Content-Type: application/json' \
        -d '{ \
            "query": "query { \
              project(fullPath: \"ghc/wasi-sdk\") { \
                pipelines(ref: \"main\", status: SUCCESS, first: 1) { nodes { \
                  jobs { nodes { \
                    name, \
                    artifacts { nodes { name, downloadPath } } } \
                  } } \
                } } \
              }" \
            }' \
        | jq -r " \
            first( \
                .data.project.pipelines.nodes[].jobs.nodes[] \
                | select(.name == \"${JOB}\") \
                | .artifacts.nodes[] \
                | select(.name == \"artifacts.zip\") \
                | .downloadPath \
            )" \
        ) \
    && curl -L "https://gitlab.haskell.org/${ARTIFACT_URL}" -o archive.zip \
    && unzip archive.zip \
    && mkdir -p ~/.ghc-wasm/wasi-sdk \
    && tar xzf dist/wasi-sdk-16-linux.tar.gz -C ~/.ghc-wasm/wasi-sdk --strip-components=1 \
    && rm -rf /tmp/wasi-sdk

# install libffi-wasm
RUN mkdir -p /tmp/libffi-wasm && cd /tmp/libffi-wasm \
    && apt-get update && apt-get install -y curl jq unzip \
    && ARTIFACT_URL=$(curl https://gitlab.haskell.org/api/graphql \
        -H 'Content-Type: application/json' \
        -d '{ \
            "query": "query { \
              project(fullPath: \"ghc/libffi-wasm\") { \
                pipelines(ref: \"master\", status: SUCCESS, first: 1) { nodes { \
                  jobs { nodes { \
                    artifacts { nodes { name, downloadPath } } } \
                  } } \
                } } \
              }" \
            }' \
        | jq -r " \
            first( \
                .data.project.pipelines.nodes[].jobs.nodes[].artifacts.nodes[] \
                | select(.name == \"artifacts.zip\") \
                | .downloadPath \
            )" \
        ) \
    && curl -L "https://gitlab.haskell.org/${ARTIFACT_URL}" -o archive.zip \
    && unzip archive.zip \
    && find . -name '*.h' | xargs -I {} mv {} ~/.ghc-wasm/wasi-sdk/share/wasi-sysroot/include/ \
    && find . -name '*.a' | xargs -I {} mv {} ~/.ghc-wasm/wasi-sdk/share/wasi-sysroot/lib/wasm32-wasi/ \
    && rm -rf /tmp/libffi-wasm

# # GHC build deps
RUN apt-get update \
    && apt-get install -y \
        alex \
        autoconf \
        build-essential \
        happy \
        python3 \
    && true

# clone GHC repo
WORKDIR /opt
RUN apt-get update \
    && apt-get install -y git \
    && git clone https://gitlab.haskell.org/ghc/ghc.git ghc-wasm

# init repo
WORKDIR /opt/ghc-wasm
ARG GHC_GIT_REF=master
RUN git checkout $GHC_GIT_REF
RUN git submodule update --init --recursive

# run build
RUN . ~/.ghc-wasm/env && ./boot && ./configure $CONFIGURE_ARGS
ARG BUILD_ARGS=-j
RUN ./hadrian/build --flavour=quick --bignum=native --docs=none $BUILD_ARGS

WORKDIR /
RUN ln -sf /opt/ghc-wasm/_build/stage1/bin/wasm32-wasi-ghc /usr/local/bin/
COPY wasm32-wasi-cabal.sh /usr/local/bin/wasm32-wasi-cabal
RUN chmod +x /usr/local/bin/wasm32-wasi-cabal
ENTRYPOINT ["wasm32-wasi-ghc"]
