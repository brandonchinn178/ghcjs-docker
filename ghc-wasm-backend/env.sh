export AR=~/.ghc-wasm/wasi-sdk/bin/llvm-ar
export CC=~/.ghc-wasm/wasi-sdk/bin/clang
export CC_FOR_BUILD=cc
export CXX=~/.ghc-wasm/wasi-sdk/bin/clang++
export LD=~/.ghc-wasm/wasi-sdk/bin/wasm-ld
export NM=~/.ghc-wasm/wasi-sdk/bin/llvm-nm
export OBJCOPY=~/.ghc-wasm/wasi-sdk/bin/llvm-objcopy
export OBJDUMP=~/.ghc-wasm/wasi-sdk/bin/llvm-objdump
export RANLIB=~/.ghc-wasm/wasi-sdk/bin/llvm-ranlib
export SIZE=~/.ghc-wasm/wasi-sdk/bin/llvm-size
export STRINGS=~/.ghc-wasm/wasi-sdk/bin/llvm-strings
export STRIP=~/.ghc-wasm/wasi-sdk/bin/llvm-strip
export CONF_CC_OPTS_STAGE2="-Wno-error=int-conversion -Wno-error=strict-prototypes -Wno-error=implicit-function-declaration -Oz -msimd128 -mnontrapping-fptoint -msign-ext -mbulk-memory -mmutable-globals -mmultivalue -mreference-types"
export CONF_CXX_OPTS_STAGE2="-Wno-error=int-conversion -Wno-error=strict-prototypes -Wno-error=implicit-function-declaration -fno-exceptions -Oz -msimd128 -mnontrapping-fptoint -msign-ext -mbulk-memory -mmutable-globals -mmultivalue -mreference-types"
export CONF_GCC_LINKER_OPTS_STAGE2="-Wl,--compress-relocations,--error-limit=0,--growable-table,--stack-first,--strip-debug -Wno-unused-command-line-argument"
export CONFIGURE_ARGS="--target=wasm32-wasi --with-intree-gmp --with-system-libffi"
