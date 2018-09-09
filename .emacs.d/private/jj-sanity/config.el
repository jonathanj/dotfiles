;; Disable copy-on-select.
(fset 'evil-visual-update-x-selection 'ignore)

;; Remove "Recentf" from helm default sources.
(setq helm-mini-default-sources '(helm-source-buffers-list
                                  helm-source-buffer-not-found))

;; Disable buggy (?) undo-tree functionality.
;; https://emacs.stackexchange.com/questions/31438/possible-not-to-use-undo-tree-in-evil-mode
;; https://github.com/syl20bnr/spacemacs/issues/298
(setq undo-tree-enable-undo-in-region nil)
