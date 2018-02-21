((nil
  (eval . (let ((root (projectile-project-root)))
            (setq-local company-clang-arguments
                        (list (quote "-stdlib=libc++")
                              (quote "-std=gnu++11")
                              (concat "-I" root)
                              (concat "-I" root "analysis")
                              (concat "-I" root "linux64-packages/include")
                              (concat "-I" root "linux64-packages/include/c++/4.9.2")
                              (concat "-I" root "linux64-packages/include/c++/4.9.2/x86_64-unknown-linux-gnu")))
            (setq-local flycheck-clang-args (list (quote "-Wno-unused-variable")
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
