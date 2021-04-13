{ pkgs ? import ./nixpkgs.nix, extraPkgs ? [ ] }:

pkgs.mkShell {
  buildInputs = with pkgs;
    [
      nodejs-12_x

      # Globally installed NPM packages (direnv scoped)
      pkgs.twilio-cli
      ngrok
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.prettier

      nodePackages.node2nix

      # keep this line if you use bash
      bashInteractive
    ] ++ extraPkgs;
}
