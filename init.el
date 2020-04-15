;; Nope, I want my copies in the system temp dir.
(setq flymake-run-in-place nil)
;; This lets me say where my temp dir is.
(setq temporary-file-directory "~/code/debug/flymake-nix-disable-in-project-tmp/tmp/")

;; open haskell file
(find-file "foo.hs")

;; start haskell and flymake modes
(require 'haskell-mode)
(haskell-mode)
(flymake-mode)

;; if this is the old version of flymake it'll create a foo_flymake*.hs file
;; if this is the new version of flymake it'll create a tmp/foo_flymake*.hs file

(message (format "value of flymake-run-in-place: %s" flymake-run-in-place))

;; debug output to see if the outputs look correct
(message (locate-library "flymake"))
