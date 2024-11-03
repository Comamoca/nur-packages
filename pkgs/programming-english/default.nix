{
  stdenv,
  lib,
  pkgs,
  fetchFromGitHub,
  fontforge,
  makeWrapper,
}:
stdenv.mkDerivation {
  pname = "programming-english";
  version = "0.1.0";
  src = pkgs.fetchFromGitHub {
    owner = "MatsumotoDesuyo";
    repo = "programming-english";
    rev = "main";
    hash = "sha256-PZRJqDMfy4F92i10jeUY0R5P45YYBvEB3hm55dSbubo=";
  };

  buildInputs = with pkgs; [ xsv ];

  buildPhase = ''
        	    xsv cat rows $src/csv/1_Basic300.csv \
                                 $src/csv/2_Advanced.csv \
                                 $src/csv/3_Premise_English100.csv \
                                 > merged.csv

        	    xsv select name merged.csv > words
        	    xsv select name $src/csv/4_Abbreviation70.csv >> words
        	    xsv select name $src/csv/5_\ Acrony.csv >> words
        	    xsv select name $src/csv/6_Reserved.csv >> words

    	    # Clean the data
    	    cat words | sed 's/[() ].*//' | uniq > tmp
    	    mv tmp words
  '';

  installPhase = ''
    	      mkdir -p $out/share/dict/csv
    	      mkdir -p $out/share/dict/json

                  cp words $out/share/dict/programming-english-dict

    	      cp -r $src/csv $out/share/dict/
    	      cp -r $src/csv $out/share/dict/json
    	    '';

  meta = {
    description = "プログラミング英語検定学習に使用するデータをいろいろ詰め合わせ";
    homepage = "https://github.com/MatsumotoDesuyo/programming-english";
    platforms = lib.platforms.all;
  };
}
