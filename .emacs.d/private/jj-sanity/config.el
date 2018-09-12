;; Disable copy-on-select.
(fset 'evil-visual-update-x-selection 'ignore)

;; Remove "Recentf" from helm default sources.
(setq helm-mini-default-sources '(helm-source-buffers-list
                                  helm-source-buffer-not-found))

;; Disable buggy (?) undo-tree functionality.
;; https://emacs.stackexchange.com/questions/31438/possible-not-to-use-undo-tree-in-evil-mode
;; https://github.com/syl20bnr/spacemacs/issues/298
(setq undo-tree-enable-undo-in-region nil)

;; Set right option to be "Option", so that symbols can be inserted.
(setq-default mac-right-option-modifier nil)

;; https://github.com/syl20bnr/spacemacs/issues/5634#issuecomment-204340185
(defun spacemacs/objective-c-file-p ()
  (and buffer-file-name
       (string= (file-name-extension buffer-file-name) "m")
       (re-search-forward "@interface"
                          magic-mode-regexp-match-limit t)))

(add-to-list 'magic-mode-alist
             (cons #'spacemacs/objective-c-file-p #'objc-mode))

