{ lib
, mkdocs
, mkdocs-material
, mkdocs-with-pdf
, plantuml-markdown
, python3
, stdenv
}:

stdenv.mkDerivation {
  name = "mkdocs-html";

  src = lib.sourceByRegex ./. [
    "^docs.*"
    "^templates.*"
    "mkdocs.yml"
  ];

  nativeBuildInputs = [
    mkdocs
    mkdocs-material
    mkdocs-with-pdf
    plantuml-markdown
    python3
  ];

  buildPhase = ''
    mkdocs build --strict -d $out
  '';

  dontConfigure = true;
  doCheck = false;
  dontInstall = true;
}
