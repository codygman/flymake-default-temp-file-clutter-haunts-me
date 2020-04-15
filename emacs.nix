# { pkgs ? (builtins.fetchGit {
#   url = "https://github.com/NixOS/nixpkgs.git";
#   rev = "3567e1f6cc204f3b999431ce9e182a86e115976f";
# }
# TODO had issue with syntax above even tho at one time it worked lol
{
pkgs ? import <nixpkgs>
{
      overlays = [
      (self: super: {
        flymake = builtins.fetchGit {
          url = "git@github.com:flymake/emacs-flymake.git";
          rev = "8701c806d5e8f4e2c6f7dea461273482ad89c029";
          ref = "master";
        };
      })
    ];
  }
}:
let
  myEmacs = pkgs.emacs;
  overrides = self: super: rec {
    flymake = builtins.fetchGit {
          url = "git@github.com:flymake/emacs-flymake.git";
          rev = "8701c806d5e8f4e2c6f7dea461273482ad89c029";
          ref = "master";
        };
    eglot = super.eglot.override({ flymake = self.flymake; });
  };
  emacsWithPackages = ((pkgs.emacsPackagesGen myEmacs).overrideScope' overrides).emacsWithPackages (p: with p; [
    p.haskellMode
    # eglot breaks for haskell if flymake writes temporary directories in place
    # This fork of flymake lets you set the `flymake-run-in-place` variable to nil
    # to disable this:
    # https://github.com/flymake/emacs-flymake#use-the-system-temporary-directory-for-temp-files
    # The manual told me that overrideScope' should be enough, so I guess I'm probably missing something
    p.eglot
  ]);
in
(pkgs.stdenv.mkDerivation {
  name = "debug-flymake-annoying-clutter";
  buildInputs = [
    emacsWithPackages
  ];
})
