{ pkgs }:
let
  stdenv = pkgs.stdenv;

  read = pkgs.emacsPackages.melpaBuild {
    pname = "nano-read";
    version = "1";

    src = pkgs.fetchFromGitHub {
      owner = "rougier";
      repo = "nano-read";
      rev = "2d04678517f2e9ae59adefc6d3bee8539daa7660";
      hash = "sha256-kC75l3fUlZLIvpVK0Las0FBzqd6pDZe+DT9JLa68+zA=";
    };
  };

  modeline = pkgs.emacsPackages.melpaBuild {
    pname = "nano-modeline";
    version = "1";

    src = pkgs.fetchFromGitHub {
      owner = "rougier";
      repo = "nano-modeline";
      rev = "04676d57a1e602123a593836745a744d1b2028fb";
      hash = "sha256-CoADZ4L4JpoF3JRMb793z2nAq8s1VE3uqb3gqFD7IOA";
    };
  };

  theme = pkgs.emacsPackages.melpaBuild {
    pname = "nano-theme";
    version = "1";

    src = pkgs.fetchFromGitHub {
      owner = "rougier";
      repo = "nano-theme";
      rev = "ffe414c8af9c673caf8b8b05ba89a229cb9ad48b";
      hash = "sha256-ecLTwFy5lerIHr1h+6LNHqzuSgfhN9sYPU/dqbTVJXI=";
    };
  };

  box = pkgs.emacsPackages.melpaBuild {
    pname = "nano-box";
    version = "1";
    buildInputs = [ modeline ];

    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rougier/nano-tools/refs/heads/master/nano-box.el";
      hash = "sha256-n2FwKfkb47cbe0KtjK5pdDVWy8m0Zq7oSye/O38roik=";
    };
  };

  popup = pkgs.emacsPackages.melpaBuild {
    pname = "nano-popup";
    version = "1";

    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rougier/nano-tools/refs/heads/master/nano-popup.el";
      hash = "sha256-pK153s06m+sDxRc/RfvbmTtcJUj7n8eRzg/2HhPy8eo=";
    };
  };

  kill = pkgs.emacsPackages.melpaBuild {
    pname = "nano-kill";
    version = "1";
    buildInputs = [ read ];

    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rougier/nano-tools/refs/heads/master/nano-kill.el";
      hash = "sha256-bQ1SSXCZWTvuAYrS8X3WTopqBj5iPxnfI4RFStPSFiE=";
    };
  };

  journal = pkgs.emacsPackages.melpaBuild {
    pname = "nano-journal";
    version = "1";
    buildInputs = [
      box
      modeline
      popup
    ];

    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rougier/nano-tools/refs/heads/master/nano-journal.el";
      hash = "sha256-/E1CchVdqB+YPkLx1rUliLDatpTECNzxZ2oT80boXgQ=";
    };
  };
in 
{
  inherit kill popup box theme modeline read journal;

  meta = {
    description = "A set of tools for emacs that are not worth to be packaged.";
    homepage = "https://github.com/rougier/nano-tools";
    platforms = lib.platforms.all;
  };
}
