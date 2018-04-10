(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-bright)))
 '(custom-safe-themes
   (quote
    ("1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
 '(safe-local-variable-values
   (quote
    ((eval let
           ((root
             (projectile-project-root)))
           (setq-local company-clang-arguments
                       (list
                        (quote "-stdlib=libc++")
                        (quote "-std=gnu++11")
                        (concat "-I" root)
                        (concat "-I" root "analysis")
                        (concat "-I" root "linux64-packages/include")
                        (concat "-I" root "linux64-packages/include/c++/4.9.2")
                        (concat "-I" root "linux64-packages/include/c++/4.9.2/x86_64-unknown-linux-gnu")))
           (setq-local flycheck-clang-args
                       (list
                        (quote "-Wno-unused-variable")
                        (quote "-stdlib=libc++")
                        (quote "-Wno-unused-parameter")
                        (quote "-Wno-inconsistent-missing-override")
                        (quote "-Wno-sign-compare")))
           (setq-local flycheck-clang-language-standard "gnu++11")
           (setq-local flycheck-clang-include-path
                       (list root
                             (concat root "analysis")
                             (concat root "linux64-packages/include")
                             (concat root "linux64-packages/include/c++/4.9.2")
                             (concat root "linux64-packages/include/c++/4.9.2/x86_64-unknown-linux-gnu")))))))
 '(session-use-package t nil (session)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
