# Mkdocs Material + PlantUML + PlantUML-C4 + Icons

This repository provides a nix flake that builds and serves an example
project documentation that is written in markdown and generated as HTML
by the mkdocs tool. It bundles multiple plugins in a handy way so you don't
have to do this yourself for every computer you use it on.

## Usage

To view the generated config offline without installing or cloning anything,
run:

```sh
nix run github:tfc/mkdocs-plantuml-c4
```

To view the checked-out version, clone the repository and from inside, run:

```sh
nix develop
mkdocs serve
```

## Packaged Tools/Plugins

- [mkdocs](https://www.mkdocs.org/)
- [mkdocs-material](https://squidfunk.github.io/mkdocs-material/)
- [plantuml](https://plantuml.com/)
- [plantuml-markdown](https://github.com/mikitex70/plantuml-markdown)
- [C4-plantuml](https://github.com/plantuml-stdlib/C4-PlantUML)
- [plantuml-icon-font-sprites](https://github.com//tupadr3/plantuml-icon-font-sprites)
