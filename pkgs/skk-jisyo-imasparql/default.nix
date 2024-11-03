{
  stdenv,
  lib,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "skk-jisyo-imasparql";
  version = "master";
  src = fetchFromGitHub {
    owner = "banjun";
    repo = "skk-jisyo-imasparql";
    rev = "fd3cfbd84a846b773f4587be636e1a29f800ef8a";
    fetchSubmodules = false;
    sha256 = "sha256-0a7Po9LKzrKYfg0kcrq5QfxJiIw/RDr/3E96We7J5NU=";
  };

  installPhase = ''
                install -D SKK-JISYO.im@sparql.all.utf8 $out/share/SKK-JISYO.im@sparql.all.utf8
                install -D SKK-JISYO.im@sparql.idols.utf8 $out/share/SKK-JISYO.im@sparql.idols.utf8
                install -D SKK-JISYO.im@sparql.units.utf8 $out/share/SKK-JISYO.im@sparql.units.utf8
    	    '';

  meta = {
    description = " Nix flake support to SKK dictionaries for idolmaster.";
    homepage = "https://github.com/banjun/skk-jisyo-imasparql";
    platforms = lib.platforms.all;
  };
}
