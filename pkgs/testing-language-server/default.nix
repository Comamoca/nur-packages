{ fetchurl, fetchgit, fetchFromGitHub, dockerTools }:
  let
    generated = import ./_sources/generated.nix;

    sources = generated {
      inherit (pkgs)
      fetchurl
      fetchgit
      fetchFromGitHub
      dockerTools;
    };
  in
    pkgs.rustPlatform.buildRustPackage {
      pname = "testing-language-server";
      version = "0.1.0";
            src = sources.testing-language-server.src;
            doCheck = false;
            cargoLock.lockFile = ./Cargo.lock;
          }
