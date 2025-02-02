{ pkgs }:
let
  version = "0.0.73";
  pname = "bsky";

  bsky-src = pkgs.fetchFromGitHub {
    owner = "mattn";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-GTuF/ZbZ84tTcbjp8eXKdpUGCsOkg2rxEcslKTsgpu4=";
  };
in
pkgs.buildGoModule {
  inherit version pname;
  src = bsky-src;
  vendorHash = "sha256-dLhrPHjhEHEJOokkjll1Z+zhDlBXuhlJJBtCFXfhyws=";

  meta = with pkgs.lib; {
    description = "A cli application for bluesky social";
    homepage = "https://github.com/mattn/bsky";
    license = licenses.mit;
  };
};
