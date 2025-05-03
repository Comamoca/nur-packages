{
  pkgs,
}:
let
  generated = import ../../_sources/generated.nix;
  sources = generated {
    fetchurl = pkgs.fetchurl;
    fetchgit = pkgs.fetchgit;
    fetchFromGitHub = pkgs.fetchFromGitHub;
    dockerTools = pkgs.dockerTools;
  };
in
pkgs.rustPlatform.buildRustPackage {
  pname = "testing-language-server";
  version = "0.1.0";
  src = sources.testing-language-server.src;
  doCheck = false; 
  cargoLock.lockFile = "${sources.testing-language-server.src}/Cargo.lock";
}
