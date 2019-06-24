;;; Need to manually install ggtags vlf ahg ace-jump, helm, helm-swoop, etc...
(normal-erase-is-backspace-mode 1)
(toggle-debug-on-error)
(require 'org)
(require 'company)
(require 'init-ak)
;; RTAGS stuff
;;; Diagnostics
(setq rtags-autostart-diagnostics t)
(rtags-diagnostics)
;;; (setq rtags-completions-enabled t)
(require 'flycheck-rtags)
;; Optional explicitly select the RTags Flycheck checker for c or c++ major mode.
;; Turn off Flycheck highlighting, use the RTags one.
;; Turn off automatic Flycheck syntax checking rtags does this manually.
(defun my-flycheck-rtags-setup ()
  "Configure flycheck-rtags for better experience."
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-check-syntax-automatically nil)
  (setq-local flycheck-highlighting-mode nil))
(add-hook 'c-mode-hook #'my-flycheck-rtags-setup)
(add-hook 'c++-mode-hook #'my-flycheck-rtags-setup)
(add-hook 'objc-mode-hook #'my-flycheck-rtags-setup)

;;; Rtags Completion
;;; (push 'company-rtags company-backends)
(define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))
(rtags-enable-standard-keybindings)
(add-hook 'c-mode-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
(add-hook 'objc-mode-hook 'rtags-start-process-unless-running)

;;; Rtags Navigation

;;; These function are not very stable
(defun use-rtags (&optional useFileManager)
  (and (rtags-executable-find "rc")
       (cond ((not (gtags-get-rootpath)) t)
             ((and (not (eq major-mode 'c++-mode))
                   (not (eq major-mode 'c-mode))) (rtags-has-filemanager))
             (useFileManager (rtags-has-filemanager))
             (t (rtags-is-indexed)))))

(defun tags-find-symbol-at-point (&optional prefix)
  (interactive "P")
  (if (and (not (rtags-find-symbol-at-point prefix)) rtags-last-request-not-indexed)
      (gtags-find-tag)))
(defun tags-find-references-at-point (&optional prefix)
  (interactive "P")
  (if (and (not (rtags-find-references-at-point prefix)) rtags-last-request-not-indexed)
      (gtags-find-rtag)))
(defun tags-find-symbol ()
  (interactive)
  (call-interactively (if (use-rtags) 'rtags-find-symbol 'gtags-find-symbol)))
(defun tags-find-references ()
  (interactive)
  (call-interactively (if (use-rtags) 'rtags-find-references 'gtags-find-rtag)))
(defun tags-find-file ()
  (interactive)
  (call-interactively (if (use-rtags t) 'rtags-find-file 'gtags-find-file)))
(defun tags-imenu ()
  (interactive)
  (call-interactively (if (use-rtags t) 'rtags-imenu 'idomenu)))

(define-key c-mode-base-map (kbd "M-.") (function rtags-find-symbol-at-point))
(define-key c-mode-base-map (kbd "M-,") (function rtags-find-references-at-point))
;; (define-key c-mode-base-map (kbd "M-;") (function rtags-find-file))
(define-key c-mode-base-map (kbd "C-.") (function rtags-find-symbol))
(define-key c-mode-base-map (kbd "C-,") (function rtags-find-references))
(define-key c-mode-base-map (kbd "C-<") (function rtags-find-virtuals-at-point))
(define-key c-mode-base-map (kbd "M-i") (function rtags-imenu))

(define-key global-map (kbd "M-.") (function rtags-find-symbol-at-point))
(define-key global-map (kbd "M-,") (function rtags-find-references-at-point))
;; (define-key global-map (kbd "M-;") (function rtags-find-file))
(define-key global-map (kbd "C-.") (function rtags-find-symbol))
(define-key global-map (kbd "C-,") (function rtags-find-references))
(define-key global-map (kbd "C-<") (function rtags-find-virtuals-at-point))
(define-key global-map (kbd "M-i") (function rtags-imenu))

;;; Disable default VC for Magit
;;; (setq vc-handled-backends nil)

(add-to-list 'load-path
             "~/.emacs.d/plugins/yasnippet")
(require-package 'yasnippet)
(yas-global-mode 1)
(require-package 'yasnippet-snippets)
(setq org-src-fontify-natively t)

(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

(defun my-put-file-name-on-clipboard ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

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

(require-package 'fzf)

(global-set-key (kbd "<f1>") 'help-command)
(global-set-key (kbd "<f2>") 'xah-cut-line-or-region)  ; cut
(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f10>")   'bm-next)
(global-set-key (kbd "<S-f10>") 'bm-previous)
(global-set-key (kbd "<f3>") 'xah-copy-line-or-region) ; copy
(global-set-key [C-f3] 'highlight-symbol-at-point)
(global-set-key (kbd "<f4>") 'yank)
(global-set-key [(f5)] 'gud-cont)
(global-set-key [(f7)] 'recompile)
(global-set-key [C-f7] 'compile)
(global-set-key (kbd "<f8>") 'rtags-display-summary)
(global-set-key (kbd "<f9>") 'ff-get-other-file)
(global-set-key [(f10)] 'gud-next)
(global-set-key [(f11)] 'gud-step)
(global-set-key [(f12)] (lambda () (interactive) (kill-buffer (current-buffer))))
;;; global-set-key [(f12)] 'delete-frame)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)


(define-key global-map (kbd "C-z") 'undo-tree-undo)
(define-key global-map (kbd "C-S-z") 'undo-tree-redo)
(define-key global-map (kbd "C-;") 'evilnc-comment-or-uncomment-lines)
(define-key global-map (kbd "C-'") 'rg)
(define-key global-map (kbd "C-x C-z") 'fzf)
(define-key global-map (kbd "C-`") 'fzf-projectile)

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
;;; Prevent stuff
;;; TODO: Handle multiple prevent directories
;;; map from machines? environment variables

(defun fzf-prevent-src-git ()
  "Run fzf in prevent directory."
  (interactive)

  (let ((process-environment
         (cons (concat "FZF_DEFAULT_COMMAND=git ls-files")
               process-environment))
        (path (locate-dominating-file "/SCRATCH/anku/prevent" ".git")))
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
          (add-to-list 'auto-mode-alist '("\\.ast$" . c-mode))))


;; Goanna stuff
(load "~/.emacs.d/site-lisp/goanna/gisl-mode.el")
(load "~/.emacs.d/site-lisp/goanna/gpsl-mode.el")
(load "~/.emacs.d/site-lisp/goanna/gxsl-mode.el")

(provide 'init-local)
;;; init-local.el ends here
