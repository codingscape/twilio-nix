import
(fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-20.09.tar.gz") {
  overlays = [ (import ./overlay.nix) ];
}
