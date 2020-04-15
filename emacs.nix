{ pkgs ? import <nixpkgs> {} }:
let
  myEmacs = pkgs.emacs;
  overrides = self: super: {
    flymake = pkgs.emacsMelpa.melpaBuild (
      builtins.fetchGit {
        url = "git@github.com:flymake/emacs-flymake.git";
        rev = "8701c806d5e8f4e2c6f7dea461273482ad89c029";
        ref = "master";
      });
    };
in
(pkgs.stdenv.mkDerivation {
  name = "debug-flymake-annoying-clutter";
  buildInputs = [
    (((pkgs.emacsPackagesGen myEmacs).overrideScope' overrides).emacsWithPackages (p: with p; [
      p.haskellMode
      p.flymake
    ]))
  ];
})
