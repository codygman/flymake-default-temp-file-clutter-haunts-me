(find-file "foo.hs")
(require 'haskell-mode)
;; Nope, I want my copies in the system temp dir.
(setq flymake-run-in-place nil)
;; This lets me say where my temp dir is.
(setq temporary-file-directory "~/code/debug/flymake-nix-disable-in-project-tmp/tmp/")
(flymake-mode)
(princ (locate-library "flymake"))
