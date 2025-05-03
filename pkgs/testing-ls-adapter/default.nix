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
  pname = "testing-ls-adapter";
  version = "0.1.0";
  cargoBuildFlags = [
    "--package"
    "testing-ls-adapter"
  ];
  src = sources.testing-language-server.src;
  doCheck = false;
  cargoLock.lockFile = "${sources.testing-language-server.src}/Cargo.lock";
}
