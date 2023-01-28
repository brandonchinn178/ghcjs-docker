FROM nixos/nix

# https://github.com/NixOS/nixpkgs/issues/208812
ARG NIXPKGS_REF=2543ab976c892bbdc5afe5bc05fbdbdce264803d
RUN nix-env \
    -f https://github.com/NixOS/nixpkgs/archive/${NIXPKGS_REF}.tar.gz \
    -iA haskell.compiler.ghcjs

ENTRYPOINT ["ghcjs"]
