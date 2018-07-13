;;; init.ak --- AK's elisp playground
;;; Commentary:
;;; ak-highlight-pattern: Show only lines starts with pattern and the line before it
;;; TODO: Do I need autoload?

;;; Code:
(defun ak-highlight-pattern ()
  "Show only lines start with pattern and the line before it."
  (interactive)
  (let ((lines (reverse (split-string (buffer-string) "\n"))))
    (let ((result
           (with-temp-buffer
             (while lines
               (let ((line (pop lines)))
                 (if (string-match "^\\\s*pattern" line)
                     (save-excursion (insert-before-markers line "\n" (pop lines) "\n"))
                   nil)))
             (reverse-region (point-min) (point-max))
             (buffer-string))))
      (insert result))))

(defun ak-fix-codexm-json()
  "Add quotes for variable names."
  (interactive)
  (replace-regexp "^\\( *\\)\\([A-Za-z_]+\\)" "\\1\"\\2\""))

(provide 'init-ak)
;;; init-ak.el ends here

