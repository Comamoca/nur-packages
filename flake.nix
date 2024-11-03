{
  description = "My personal NUR repository";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    default-systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      nixpkgs,
      treefmt-nix,
      flake-parts,
      default-systems,
    }:
    let
      systems = [
        "x86_64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "armv6l-linux"
        "armv7l-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
      eachSystem =
        f: nixpkgs.lib.genAttrs (import default-systems) (system: f nixpkgs.legacyPackages.${system});
      treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
    in
    {
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
      checks = eachSystem (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      });

      legacyPackages = forAllSystems (
        system:
        import ./default.nix {
          pkgs = import nixpkgs { inherit system; };
        }
      );

      packages = forAllSystems (
        system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system}
      );

      devShells = forAllSystems (system: {
        default =
          let
            pkgs = import nixpkgs { inherit system; };

            update-pkgsinfo = pkgs.writeShellScriptBin "update-pkgsinfo" ''
              nix eval --json .#packages.x86_64-linux --apply 'pkgs:
                builtins.listToAttrs (
                  builtins.map (pkgName:
                    { name = pkgName;
                      value = {
                        name = pkgs.''${pkgName}.meta.name or "N/A";
                        description = pkgs.''${pkgName}.meta.description or "N/A";
                        homepage = pkgs.''${pkgName}.meta.homepage or "N/A";
                        license = pkgs.''${pkgName}.meta.license.shortName or "N/A";
                        platforms = builtins.filter (
                          x: x == "x86_64-linux" || x == "aarch64-linux" || x == "x86_64-darwin" || x == "aarch64-darwin"
                        ) (pkgs.''${pkgName}.meta.platforms or []);
                      };
                    }
                  ) (builtins.attrNames pkgs)
                )' > pkgsinfo.json

              cat pkgsinfo.json | jq -r '
                "Name|Description|Homepage|License|Platforms|",
                "----|-----------|--------|-------|---------|",
                (.[] |  [.name, .description, .homepage, .license, (.platforms | join(", "))] | join("|"))
                | @text' > pkgsinfo

              sed "/{PACKAGE_LIST}/ {
                  r pkgsinfo
                  d
              }" README.md.tmpl > README.md

	      rm pkgsinfo
	    '';
          in
          pkgs.mkShellNoCC {
            packages = [ update-pkgsinfo ];
          };
      });
    };
}
