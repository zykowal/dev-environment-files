;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Performance optimization
(setq gc-cons-threshold 100000000)  ; 100mb
(setq read-process-output-max (* 1024 1024)) ; 1mb
(setq lsp-idle-delay 0.500)  ; 500ms
(setq lsp-log-io nil)  ; disable log
(setq lsp-completion-provider :capf)
(setq lsp-headerline-breadcrumb-enable nil)
(setq lsp-ui-doc-enable nil)  ; disable hover doc by default
(setq lsp-ui-sideline-enable nil)  ; disable sideline
(setq lsp-modeline-diagnostics-enable nil)  ; disable modeline diagnostics
(setq lsp-lens-enable nil)  ; disable code lens
(setq company-idle-delay 0.5)  ; 500ms delay before showing completions
(setq company-minimum-prefix-length 2)  ; show completions after 2 chars
(setq which-key-idle-delay 0.5)  ; 500ms delay for which-key
(setq doom-theme 'doom-one)  ; use doom-one theme

;; Font settings
(setq doom-font (font-spec :family "Iosevka" :size 18))

;; Line numbers
(setq display-line-numbers-type t)

;; Org directory
(setq org-directory "~/org/")

;; Go configuration
(after! go-mode
  ;; Format on save
  (add-hook 'before-save-hook #'gofmt-before-save)
  
  ;; Set tab width to 4 for Go files
  (setq-default tab-width 4)
  
  ;; Configure gopls (Go language server)
  (setq lsp-go-analyses
        '((nilness . t)
          (unusedparams . t)
          (unusedwrite . t)
          (useany . t)))
  
  ;; LSP performance settings for Go
  (setq lsp-go-hover-kind "SingleLine")  ; simpler hover
  (setq lsp-go-link-target "pkg.go.dev")  ; faster documentation links
  (setq lsp-go-import-shortcut "Both")
  
  ;; Enable only essential features
  (setq lsp-enable-symbol-highlighting t)
  (setq lsp-enable-indentation t)
  (setq lsp-diagnostics-provider :flycheck)
  
  ;; Automatically start LSP when opening Go files
  (add-hook 'go-mode-hook #'lsp-deferred))

;; LSP auto-start configuration
;; Automatically start LSP for supported programming languages
(use-package! lsp-mode
  :commands lsp lsp-deferred
  :hook
  (go-mode . lsp-deferred)  ; Auto-start LSP for Go files
  (python-mode . lsp-deferred)  ; Uncomment if you use Python
  (rust-mode . lsp-deferred)  ; Uncomment if you use Rust
  (js-mode . lsp-deferred)  ; Uncomment if you use JavaScript
  (typescript-mode . lsp-deferred)  ; Uncomment if you use TypeScript
  (web-mode . lsp-deferred)  ; Uncomment if you use web-mode
  :config
  ;; LSP performance settings
  (setq lsp-auto-guess-root t)  ; Auto-guess project root
  (setq lsp-keep-workspace-alive nil)  ; Kill LSP server when closing last buffer
  (setq lsp-enable-file-watchers nil)  ; Disable file watchers for better performance
  (setq lsp-enable-on-type-formatting nil)  ; Disable on-type formatting for better performance
  (setq lsp-enable-links nil)  ; Disable links for better performance
  (setq lsp-enable-dap-auto-configure nil)  ; Don't auto-configure debug adapter
  (setq lsp-modeline-code-actions-enable nil)  ; Disable code actions on modeline
  (setq lsp-modeline-diagnostics-enable nil)  ; Disable diagnostics on modeline
  (setq lsp-headerline-breadcrumb-enable nil)  ; Disable breadcrumb
  (setq lsp-semantic-tokens-enable nil)  ; Disable semantic tokens for better performance
  (setq lsp-completion-provider :capf)  ; Use capf for completion
  (setq lsp-idle-delay 0.5)  ; Delay before processing
  (setq lsp-response-timeout 5)  ; Increase response timeout
  (setq lsp-enable-snippet nil)  ; Disable snippets
  (setq lsp-keymap-prefix "C-c l")  ; Set LSP keymap prefix
  
  ;; Enable signature help
  (setq lsp-signature-auto-activate t)         ; 启用自动签名帮助
  (setq lsp-signature-render-documentation t)  ; 显示文档
  (setq lsp-signature-doc-lines 3)            ; 显示更多行的文档
  (setq lsp-signature-delay 0.1)              ; 降低显示延迟
  (setq lsp-signature-activate-after-completion t) ; 补全后也显示签名
  
  ;; LSP UI settings
  (setq lsp-ui-doc-enable nil)                  ; 启用文档显示
  (setq lsp-ui-sideline-enable nil)             ; 启用边栏
  (setq lsp-ui-peek-enable nil)                 ; 启用查看功能
  (setq lsp-lens-enable nil))                   ; 启用代码镜头

;; Projectile settings
(after! projectile
  (setq projectile-enable-caching t)
  (setq projectile-indexing-method 'hybrid))

;; Company settings
(after! company
  (setq company-tooltip-limit 5
        company-tooltip-minimum-width 40
        company-tooltip-maximum-width 60))

;; Flycheck settings
(after! flycheck
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

;; Which-key settings
(after! which-key
  (setq which-key-sort-order 'which-key-key-order-alpha
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10))

;; Garbage collection settings
(add-hook 'focus-out-hook #'garbage-collect)  ; GC when frame loses focus


;; Rust configuration
(after! rustic
  (setq rustic-format-on-save t)

  ;; rust-analyzer
  (setq rustic-lsp-server 'rust-analyzer)
  (setq lsp-rust-analyzer-server-display-inlay-hints t)
  (setq lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (setq lsp-rust-analyzer-display-chaining-hints t)
  (setq lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (setq lsp-rust-analyzer-display-closure-return-type-hints t)
  (setq lsp-rust-analyzer-display-parameter-hints nil)
  (setq lsp-rust-analyzer-display-reborrow-hints nil)

  ;;  Clippy
  (setq lsp-rust-analyzer-cargo-watch-command "clippy")

  ;; test
  (setq rustic-test-arguments "--all-features")

  ;; indent
  (setq rust-indent-offset 4))

;; lsp
(add-hook 'rust-mode-hook #'lsp-deferred)

;; Add keybinding for signature help
(map! :after lsp-mode
      :map lsp-mode-map
      :leader
      (:prefix ("c" . "code")
       :desc "Show signature help" "s" #'lsp-signature-activate))

;; React/JavaScript/TypeScript configuration
(after! web-mode
  ;; Set indentation
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-attr-indent-offset 2)
  
  ;; Auto-close tags
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-pairing t)
  
  ;; Highlight matching elements
  (setq web-mode-enable-current-element-highlight t)
  
  ;; Enable JSX syntax highlighting in .js files
  (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . web-mode))
  (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
  
  ;; Enable TypeScript and TSX support
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
  (add-to-list 'web-mode-content-types-alist '("tsx" . "\\.tsx\\'")))

;; JavaScript/TypeScript LSP configuration
(after! lsp-mode
  ;; Configure LSP for JavaScript and TypeScript
  (setq lsp-typescript-suggest-complete-function-calls t)
  (setq lsp-typescript-format-enable t)
  (setq lsp-javascript-format-enable t)
  
  ;; Enable code actions on save (like auto-imports)
  (setq lsp-typescript-suggest-auto-imports t)
  (setq lsp-javascript-suggest-auto-imports t)
  
  ;; Enable React specific features
  (setq lsp-typescript-suggest-complete-jsx-tags t)
  
  ;; Auto-start LSP for web files
  (add-hook 'web-mode-hook #'lsp-deferred)
  (add-hook 'typescript-mode-hook #'lsp-deferred)
  (add-hook 'js2-mode-hook #'lsp-deferred))

;; Biome configuration
(defun biome-format-buffer ()
  "Format the current buffer using Biome."
  (interactive)
  (let ((file (buffer-file-name))
        (buffer (current-buffer))
        (point (point)))
    (when file
      (message "Formatting with Biome: %s" file)
      (call-process "biome" nil nil nil "format" "--write" file)
      (revert-buffer t t t)
      (goto-char point)
      (message "Biome formatting done"))))

;; Emmet for JSX
(use-package! emmet-mode
  :hook (web-mode . emmet-mode)
  :config
  (setq emmet-expand-jsx-className? t)
  (setq emmet-self-closing-tag-style " /"))

;; Enable Biome format-on-save for web files
(add-hook! (web-mode typescript-mode js2-mode)
  (add-hook 'before-save-hook #'biome-format-buffer nil t))
