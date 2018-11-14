(defconst jj-python-packages
  '(py-isort
    subword
    python
    python-docstring
    ))

(defun jj-python/init-py-isort ()
  (use-package py-isort
    :defer t
    :init
    (spacemacs/set-leader-keys-for-major-mode 'python-mode
      "os" 'jj-python/py-isort-region)))

(defun jj-python/init-python-docstring ()
  (use-package python-docstring
    :defer t))

(defun jj-python/pre-init-python ()
  (spacemacs|use-package-add-hook python
    :post-config
    (progn
      (add-hook 'python-mode-hook 'python-docstring-mode)
      (add-hook 'python-mode-hook 'subword-mode)
      )))
