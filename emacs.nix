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
    eglot = super.eglot.overrideAttrs (oa: {
      # this didn't work
      # flymake = self.flymake;
      #
      # I see in the repl:
      # nix-repl> pkgs.emacsMelpa.eglot.propagatedUserEnvPkgs
      # [ «derivation /nix/store/ir9kz2p6yihadycc8h4ifibbn8bba5wa-emacs-flymake-1.0.8.drv» «derivation /nix/store/m17asap91x4pax2ay0nykgpk504wsi2x-emacs-jsonrpc-1.0.9.drv» ]
      # maybe i can override that
      propogatedUserEnvPkgs = [];
    });
  };
  emacsWithPackages = ((pkgs.emacsPackagesGen myEmacs).overrideScope' overrides).emacsWithPackages (p: with p; [
    p.haskellMode
    p.eglot
  ]);
in
(pkgs.stdenv.mkDerivation {
  name = "debug-flymake-annoying-clutter";
  buildInputs = [
    emacsWithPackages
  ];
})
# in
# pkgs.stdenv.mkDerivation {
#   name = "debug-flymake-annoying-clutter";
#   buildInputs = [ emacsWithPackages (p: []) ];
  # buildInputs = [
  #   emacsWithPackages (p: with p; [
  #     haskellMode
  #     eglot
  #   ])
  # ];
# }
