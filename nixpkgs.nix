import
(fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-21.05.tar.gz") {
  overlays = [ (import ./overlay.nix) ];
}
