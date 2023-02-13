{ lib
, python3
, python3Packages
, stdenv
}:

stdenv.mkDerivation {
  name = "mkdocs-html";

  src = lib.sourceByRegex ./. [
    "^docs.*"
    "mkdocs.yml"
  ];

  nativeBuildInputs = [
    python3
    python3Packages.mkdocs
    python3Packages.mkdocs-material
    python3Packages.plantuml-markdown
  ];

  buildPhase = ''
    mkdocs build --strict -d $out
  '';

  dontConfigure = true;
  doCheck = false;
  dontInstall = true;
}
