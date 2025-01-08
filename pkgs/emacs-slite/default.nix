{ pkgs }:
{
  slite = pkgs.emacsPackages.melpaBuild {
    pname = "slite";
    version = "1";
    buildInputs = [ ];

    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/tdrhq/slite/refs/heads/main/slite.el";
      hash = "sha256-ohVZUSpHNDLna6BmFtgtUSKV7Pj6Nj+67imVWXWn+mQ=";
    };
  };

  meta = {
    description = "a SLIme-based TEst runner for FiveAM and Parachute Tests";
    homepage = "https://github.com/tdrhq/slite";
    platforms = pkgs.lib.platforms.all;
  };
}
