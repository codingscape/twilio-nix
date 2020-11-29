{ lib, stdenv, pkgs, fetchgit }:

let
  nodePackages = import ./node-composition.nix {
    inherit pkgs;
    inherit (stdenv.hostPlatform) system;
  };

in nodePackages.twilio-cli.override {
  buildInputs = [ pkgs.libsecret ] ++ lib.optional stdenv.isDarwin [
    pkgs.xcodebuild
    pkgs.darwin.apple_sdk.frameworks.Security
    pkgs.darwin.apple_sdk.frameworks.AppKit
  ];
}
