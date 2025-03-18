;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Performance optimization
(setq doom-theme 'doom-one)  ; use doom-one theme

;; Font settings
(setq doom-font (font-spec :family "Iosevka" :size 18)
      doom-variable-pitch-font (font-spec :family "Iosevka" :size 18)
      doom-unicode-font (font-spec :family "Iosevka" :size 18))

;; Line numbers
(setq display-line-numbers-type 'visual)

;; Org directory
(setq org-directory "~/org/")

;; Company settings
(after! company
  (setq company-tooltip-minimum-width 80
        company-tooltip-align-annotations t
        company-tooltip-flip-when-above t
        company-tooltip-maximum-width 80))

(use-package! lsp-tailwindcss :after lsp-mode)
