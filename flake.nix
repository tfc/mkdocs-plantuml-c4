{
  description = "Mkdocs PlantUML C4 Example Project Documentation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      perSystem = { config, pkgs, system, ... }:
        let
          python3Packages = (pkgs.python3.override {
            packageOverrides = pFinal: pPrev: {
              mkdocs-with-pdf = pFinal.callPackage ./mkdocs-with-pdf.nix { };
              plantuml-markdown = pPrev.plantuml-markdown.override {
                plantuml = pkgs.plantuml-c4;
              };
            };
          }).pkgs;
        in
        {
          packages = {
            default = config.packages.html;
            html = pkgs.callPackage ./build.nix { inherit python3Packages; };
            pdf = config.packages.html.overrideAttrs (old: {
              name = "sensorstack-documentation.pdf";
              ENABLE_PDF_EXPORT = 1;
              buildPhase = ''
                mkdocs build
                cp site/documentation.pdf $out
              '';
            });
          };

          apps = {
            default = config.apps.serve-docs;
            serve-docs = {
              type = "app";
              program = builtins.toString (pkgs.writeShellScript "serve-docs" ''
                exec ${pkgs.python3}/bin/python3 -m http.server \
                    --bind 127.0.0.1 \
                    --directory ${config.packages.html}
              '');
            };
          };

          checks = {
            pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                cspell = {
                  enable = true;
                  entry = "${pkgs.nodePackages.cspell}/bin/cspell --words-only";
                  types = [ "markdown" ];
                };
                markdownlint.enable = true;
                nixpkgs-fmt.enable = true;
                statix.enable = true;
              };
            };
          };

          devShells.default = pkgs.mkShell {
            inputsFrom = [ config.packages.html ];
            shellHook = ''
              ${config.checks.pre-commit-check.shellHook}
            '';
          };
        };
    };
}
