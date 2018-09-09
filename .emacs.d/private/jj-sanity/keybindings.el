;; Make <leader>, switch to the last buffer.
(spacemacs/set-leader-keys
  "," 'spacemacs/alternate-buffer
  )

;; :q should just kill the buffer, like in vim.
(evil-ex-define-cmd "q[uit]" 'spacemacs/kill-this-buffer)

;; Make C-w work in the minibuffer.
(define-key minibuffer-local-map (kbd "C-w") 'evil-delete-backward-word)

;; Make window switching work with the arrow keys.
(define-key evil-window-map (kbd "<up>") 'evil-window-up)
(define-key evil-window-map (kbd "<down>") 'evil-window-down)
(define-key evil-window-map (kbd "<left>") 'evil-window-left)
(define-key evil-window-map (kbd "<right>") 'evil-window-right)

;; Make C-] use gtags to Do What I Mean.
(define-key evil-motion-state-map (kbd "C-]") 'helm-gtags-dwim)

;; Make home and end move along the line instead of the file.
(global-set-key (kbd "<home>") 'move-beginning-of-line)
(global-set-key (kbd "<end>") 'move-end-of-line)

;; Disable three-finger swipe to switch buffers.
(global-unset-key [swipe-left])
(global-unset-key [swipe-right])

(when (spacemacs/system-is-mac)
  ;; Make Cmd movement keys work like the rest of macOS.
  (global-set-key (kbd "<H-left>") 'move-beginning-of-line)
  (global-set-key (kbd "<H-right>") 'move-end-of-line)
  (global-set-key (kbd "<H-up>") 'beginning-of-buffer)
  (global-set-key (kbd "<H-down>") 'end-of-buffer)

  ;; Killing a split/window is annoying, rather just kill the buffer.
  (global-set-key (kbd "<H-w>") 'spacemacs/kill-this-buffer)

  ;; Indent text with Cmd-] in any mode, preserving the block in visual mode.
  (define-key evil-normal-state-map (kbd "H-]") 'evil-shift-right-line)
  (define-key evil-insert-state-map (kbd "H-]") 'evil-shift-right-line)
  (define-key evil-visual-state-map (kbd "H-]")
    (lambda nil
      (interactive)
      (progn (call-interactively (quote
                                  evil-shift-right)) (execute-kbd-macro "gv"))))
  ;; Dedent text with Cmd-[ in any mode, preserving the block in visual mode.
  (define-key evil-normal-state-map (kbd "H-[") 'evil-shift-left-line)
  (define-key evil-insert-state-map (kbd "H-[") 'evil-shift-left-line)
  (define-key evil-visual-state-map (kbd "H-[")
    (lambda nil
      (interactive)
      (progn (call-interactively (quote
                                  evil-shift-left)) (execute-kbd-macro "gv"))))
  )
