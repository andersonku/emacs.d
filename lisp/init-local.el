;;; Need to manually install ggtags vlf ahg ace-jump, helm, helm-swoop, etc...

(require 'org)

(defun xah-copy-line-or-region ()
  "Copy current line, or text selection.
When `universal-argument' is called first, copy whole buffer (but respect `narrow-to-region')."
  (interactive)
  (let (p1 p2)
    (if (null current-prefix-arg)
        (progn (if (use-region-p)
                   (progn (setq p1 (region-beginning))
                          (setq p2 (region-end)))
                 (progn (setq p1 (line-beginning-position))
                        (setq p2 (line-end-position)))))
      (progn (setq p1 (point-min))
             (setq p2 (point-max))))
    (kill-ring-save p1 p2)))

(defun xah-cut-line-or-region ()
  "Cut current line, or text selection.
When `universal-argument' is called first, cut whole buffer (but respect `narrow-to-region')."
  (interactive)
  (let (p1 p2)
    (if (null current-prefix-arg)
        (progn (if (use-region-p)
                   (progn (setq p1 (region-beginning))
                          (setq p2 (region-end)))
                 (progn (setq p1 (line-beginning-position))
                        (setq p2 (line-beginning-position 2)))))
      (progn (setq p1 (point-min))
             (setq p2 (point-max))))
    (kill-region p1 p2)))

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key (kbd "<f1>") 'help-command)
(global-set-key (kbd "<f2>") 'xah-cut-line-or-region)  ; cut
(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f10>")   'bm-next)
(global-set-key (kbd "<S-f10>") 'bm-previous)
(global-set-key (kbd "<f3>") 'xah-copy-line-or-region) ; copy
(global-set-key [C-f3] 'highlight-symbol-at-point)
(global-set-key (kbd "<f4>") 'yank)
(global-set-key [(f5)] 'recompile)
(global-set-key [(f29)] 'compile)
(global-set-key [C-f5] 'compile)
(global-set-key (kbd "<f8>") 'ggtags-find-tag-dwim)
(global-set-key (kbd "<f9>") 'ff-get-other-file)
(global-set-key [(f11)] 'kill-this-buffer)
(global-set-key [(C-f11)] 'kill-this-buffer)
(global-set-key [(f12)] 'delete-frame)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

(define-key global-map (kbd "C-z") 'undo-tree-undo)
(define-key global-map (kbd "C-x C-z") 'fzf)
(define-key global-map (kbd "C-S-z") 'undo-tree-redo)
(define-key global-map (kbd "C-;") 'evilnc-comment-or-uncomment-lines)
;;; (global-set-key  (kbd "C-c C-c") 'evilnc-comment-or-uncomment-lines)

(define-key global-map (kbd "M-RET") 'ace-jump-mode)
(global-set-key [(control up)]  'move-line-up)
(global-set-key [(control down)]  'move-line-down)
(global-set-key [(control l)] 'kill-whole-line)
(global-set-key [?\e deletechar] 'kill-word)

(global-set-key (kbd "<left-fringe> <mouse-5>") 'bm-next-mouse)
(global-set-key (kbd "<left-fringe> <mouse-4>") 'bm-previous-mouse)
(global-set-key (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)

(setq redisplay-dont-pause t)

;; Was this for some 1A crap?
;; (remove-hook 'find-file-hooks 'vc-find-file-hook)
;; (setq vc-handled-backends ())

;; (require 'vlf-setup)

(require-package 'goto-last-change)
(global-set-key "\C-x\C-\\" 'goto-last-change)

;; (require 'ace-isearch)
;; (global-ace-isearch-mode +1)

;; (custom-set-variables
;;  '(ace-isearch-input-length 99))

;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst emacs-tmp-dir (format "%s/%s%s/" temporary-file-directory "emacs" (user-uid)))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; (require 'google-c-style)
;; (add-hook 'c-mode-common-hook 'google-set-c-style)
;; (add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
;;               (ggtags-mode 1))))

(require-package 'ace-jump-mode)
(require-package 'highlight-symbol)
(require-package 'bm)
(require-package 'fzf)

;;; Prevent stuff
(defun fzf-prevent-src-git ()
  "Run fzf in prevent directory."
  (interactive)

  (let ((process-environment
         (cons (concat "FZF_DEFAULT_COMMAND=git ls-files")
               process-environment))
        (path (locate-dominating-file default-directory ".git")))
    (if path
        (fzf/start "/SCRATCH/anku/prevent")
      (user-error "Not inside a Git repository"))))

(if (file-directory-p "/SCRATCH/anku/prevent/scripts/emacs/")
    (progn(add-to-list 'load-path "/SCRATCH/anku/prevent/scripts/emacs/")
          (load "prevent-common")
          (load "prevent-copyright")
          (load "prevent-gdb")
          (load "prevent-compile")
          (load "prevent-create-source.el")
          (load "prevent-insert-include.el")
          (load "prevent-syntax")
          (load "codexm-mode")

          (add-hook 'c-mode-common-hook 'prevent-indentation)

          (defun my-prevent-config ()
            (local-set-key (kbd "{") 'prevent-start-block) ; add a key
            )

          (add-hook 'c-mode-common-hook 'my-prevent-config)
          (define-key global-map (kbd "C-`") 'fzf-prevent-src-git)
          (add-to-list 'auto-mode-alist '("\\.ast$" . c-mode))))

(provide 'init-local)
;;; init-local.el ends here
