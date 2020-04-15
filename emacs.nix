{ pkgs ? import <nixpkgs> {} }:
let
  myEmacs = pkgs.emacs;
  overrides = self: super: {
    flymake = super.flymake.overrideAttrs (oa: {
      src = builtins.fetchGit {
        url = "git@github.com:flymake/emacs-flymake.git";
        rev = "8701c806d5e8f4e2c6f7dea461273482ad89c029";
        ref = "master";
      };
    });
  };
  emacsWithPackages = ((pkgs.emacsPackagesGen myEmacs).overrideScope' overrides).emacsWithPackages;
in
  emacsWithPackages (p: with p; [
    haskellMode
    eglot
  ])
