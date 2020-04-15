{ pkgs ? import <nixpkgs> {} }:
let
  myEmacs = pkgs.emacs;
  overrides = self: super: {
    lua-mode = (super.lua-mode.override (args: {
      melpaBuild = drv: args.melpaBuild (drv // {
        src = pkgs.fetchFromGitHub {
          owner = "immerrr";
          repo = "lua-mode";
          rev = "95c64bb5634035630e8c59d10d4a1d1003265743";
          sha256 = "0cawb544qylifkvqads307n0nfqg7lvyphqbpbzr2xvr5iyi4901";
          # date = 2019-01-13T13:50:39+03:00;
        };
      });
    }));


    flymake = (super.flymake.override (args: {
      melpaBuild = drv: args.melpaBuild (drv);
    }));
    # flymake = (super.flymake.override (args: {
    #   melpaBuild = drv: args.melpaBuild (drv // {
    #     src = pkgs.fetchFromGitHub {
    #       owner = "flymake";
    #       repo = "emacs-flymake";
    #       rev = "8701c806d5e8f4e2c6f7dea461273482ad89c029";
    #       # sha256 = "0000000000000000000000000000000000000000000000000000";
    #     };
    #   });
    # }));



    # flymake = (super.flymake.override (args: {
    #   melpaBuild = drv: args.melpaBuild (drv // {
    #     src = builtins.fetchGit {
    #       url = "git@github.com:flymake/emacs-flymake.git";
    #       rev = "8701c806d5e8f4e2c6f7dea461273482ad89c029";
    #       ref = "master";
    #     };
    #   });
    # }));

    # flymake = pkgs.emacsMelpa.melpaBuild (
      # builtins.fetchGit {
      #   url = "git@github.com:flymake/emacs-flymake.git";
      #   rev = "8701c806d5e8f4e2c6f7dea461273482ad89c029";
      #   ref = "master";
    #   }) {};
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
