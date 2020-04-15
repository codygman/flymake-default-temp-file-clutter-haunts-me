export HOME=$(pwd)
nix-shell --pure emacs.nix --keep HOME --run "emacs --batch --eval='(load \"$HOME/init.el\")'"




#nix-shell --pure emacs.nix --keep HOME --run "cd ~/code/debug/flymake-nix-disable-in-project-tmp; emacs foo.hs --no-init --eval='(load \"init.el\")'"
#nix-shell --pure doomemacs.nix --keep HOME --run "env HOME=$HOME emacs --eval='(load \"$HOME/init.el\")'"
