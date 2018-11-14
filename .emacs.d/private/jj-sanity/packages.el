(defconst jj-sanity-packages
  '(simpleclip
    web-mode
    smartparens
    (python :location built-in)
    ;;spaceline-all-the-icons
    neotree
    ))


(defun jj-sanity/init-simpleclip ()
  (use-package simpleclip
    :config
    (simpleclip-mode 1)))


(defun jj-sanity/post-init-spaceline-all-the-icons ()
  (spaceline-all-the-icons-theme)
  (spaceline-toggle-all-the-icons-region-info-off)
  ;; Turn off (pointless) "minimap" feature.
  (spaceline-toggle-all-the-icons-hud-off))


(defun jj-sanity/post-init-neotree ()
  ;; Don't prompt when changing the neotree root.
  (setq neo-force-change-root t))


(defun jj-sanity/post-init-python ()
  ;; Irritatingly broken matching behaviour.
  (remove-hook 'python-mode-hook 'turn-on-evil-matchit-mode)
  ;; Whatever provides the eldoc information is really slow.
  (remove-hook 'python-mode-hook 'eldoc-mode))


(defun jj-sanity/post-init-smartparens ()
  ;; Disable smartparens because it's annoying in everything but lisp.
  (remove-hook 'prog-mode-hook 'smartparens-mode))


(defun jj-sanity/post-init-web-mode ()
  ;; JSX in `web-mode`
  (setq web-mode-content-types-alist
        '(("jsx" . "\\.jsx?\\'")))
  (setq web-mode-markup-indent-offset 2)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode)))
