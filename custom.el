(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-bright)))
 '(custom-safe-themes
   (quote
    ("1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
 '(package-selected-packages
   (quote
    (yasnippet-snippets yari yard-mode yagist xref-js2 writeroom-mode whole-line-or-region whitespace-cleanup-mode wgrep-ag vlf vc-darcs unfill undo-tree typescript-mode toml-mode tidy textile-mode tagedit symbol-overlay switch-window sql-indent smex smarty-mode slime-company skewer-less session scss-mode scratch sass-mode ruby-hash-syntax ruby-compilation rspec-mode robe restclient regex-tool rainbow-mode rainbow-delimiters racer purescript-mode psc-ide projectile-ripgrep projectile-rails project-local-variables prettier-js pip-requirements php-mode paredit-everywhere page-break-lines origami org-pomodoro org-plus-contrib org-fstree org-cliplink org nlinum nix-sandbox nix-mode nix-buffer nginx-mode multiple-cursors move-dup mode-line-bell mmm-mode magithub magit-gh-pulls lua-mode list-unicode-display less-css-mode ledger-mode js-comint ivy-xref ivy-historian ipretty intero immortal-scratch ibuffer-vc httprepl htmlize hippie-expand-slime hindent highlight-symbol highlight-quoted highlight-indentation highlight-escape-sequences guide-key goto-last-change goto-gem gnuplot gitignore-mode github-issues github-clone gitconfig-mode git-timemachine git-messenger git-blamed fzf fullframe free-keys flycheck-package flycheck-ledger flycheck-elm flycheck-color-mode-line flycheck-clojure expand-region exec-path-from-shell evil-nerd-commenter erlang elm-mode elisp-slime-nav elein dynamic-spaces dsvn dotenv-mode dockerfile-mode docker-compose-mode docker disable-mouse diredfl dired-sort dimmer diminish diff-hl dhall-mode default-text-scale darcsum csv-nav csv-mode css-eldoc counsel company-terraform company-quickhelp company-nixos-options company-anaconda command-log-mode color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized coffee-mode cmd-to-echo cljsbuild-mode cl-lib-highlight cask-mode bundler bug-reference-github browse-kill-ring browse-at-remote bm beacon avy auto-compile anzu aggressive-indent ag add-node-modules-path ace-jump-mode ace-isearch 0blayout)))
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
