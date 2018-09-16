(defconst jj-clojure-packages
  '(paredit
    paxedit
    clojure-mode
    ))

(defun jj-clojure/init-paxedit ()
  (use-package paxedit
    :defer t
    :init
    (add-hook 'clojure-mode-hook 'paxedit-mode)))

(defun jj-clojure/init-paredit ()
  (use-package paredit
    :defer t
    :init
    (add-hook 'clojure-mode-hook 'paredit-mode)))

(defun jj-clojure/pre-init-clojure-mode ()
  (spacemacs|use-package-add-hook clojure-mode
    :post-config
    (progn
      (setq ggtags-bounds-of-tag-function 'jj-clojure/ggtags-bounds-of-tag)
      (put 'defui 'clojure-backtracking-indent '(1 1))
      (put 'lazy-loop 'clojure-backtracking-indent '(1 1))
      (add-hook 'clojure-mode-hook 'smartparens-mode)
      )))
