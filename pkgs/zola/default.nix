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
  pname = "zola";
  version = sources.zola.version;
  src = sources.zola.src;
  doCheck = false;
  cargoLock.lockFile = "${sources.zola.src}/Cargo.lock";
}
