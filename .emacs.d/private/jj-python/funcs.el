(defun jj-python/py-isort-region ()
  "Sort imports for a region if there is one, otherwise sort the whole
  buffer."
  (interactive)
  (if (use-region-p)
      (py-isort-region)
    (py-isort-buffer)))
