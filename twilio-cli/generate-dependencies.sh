#!/usr/bin/env nix-shell
#! nix-shell -i bash -p nodePackages.node2nix

node2nix \
  --nodejs-12 \
  --node-env node-env.nix \
  --input node-packages.json \
  --output node-packages.nix \
  --composition node-composition.nix
