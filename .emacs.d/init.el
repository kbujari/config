(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)
(when (< emacs-major-version 27)
  (package-initialize)
  (load (concat user-emacs-directory "early-init.el")))

(require 'package)
(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(when (< emacs-major-version 29)
  (unless (package-installed-p 'use-package)
    (unless package-archive-contents
      (package-refresh-contents))
    (package-install 'use-package)))

(setq inhibit-startup-message t
      inhibit-splash-screen t
      blink-cursor-mode 0
      use-file-dialog nil
      display-line-numbers-type 'relative)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

(global-hl-line-mode +1)
(global-display-line-numbers-mode +1)
(global-display-fill-column-indicator-mode 1)
(set-default-coding-systems 'utf-8)

(show-paren-mode 1)
(setq show-paren-delay 0)

(when (fboundp 'which-key-mode)
  (which-key-mode 1))

(when (member "Iosevka" (font-family-list))
  (set-face-attribute 'default nil :font "Iosevka" :height 124)
  (set-face-attribute 'fixed-pitch nil :family "Iosevka"))

(load-theme 'modus-vivendi t)

(add-hook 'before-save-hook #'delete-trailing-whitespace)

(use-package evil :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  :hook
  (prog-mode . turn-on-evil-mode)
  (text-mode . turn-on-evil-mode))

(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode))

(use-package marginalia
  :ensure t
  :hook (after-init . marginalia-mode))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

(use-package corfu
  :ensure t
  :hook (after-init . global-corfu-mode)
  :bind (:map corfu-map ("<tab>" . corfu-complete))
  :config
  (setq tab-always-indent 'complete)
  (setq corfu-preview-current nil)
  (setq corfu-min-width 20)
  (setq corfu-popupinfo-delay '(1.25 . 0.5))
  (corfu-popupinfo-mode 1))

(use-package dired
  :ensure nil
  :commands (dired)
  :hook
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :config
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-dwim-target t))

(use-package nix-mode :ensure t
  :mode "\\.nix\\'")

(use-package rust-mode :ensure t)

(use-package geiser
  :ensure t)

(use-package geiser-guile
  :ensure t)

(use-package magit
  :ensure t)

(use-package eglot
  :ensure t
  :bind (("M-TAB" . completion-at-point)
         :map
         eglot-mode-map
         ("C-c c a" . eglot-code-actions)
         ("C-c c r" . eglot-rename)
         ("C-c c f" . eglot-format))
  :hook
  (rust-mode . eglot-ensure)
  (nix-mode . eglot-ensure))

(use-package envrc
  :ensure t
  :hook (after-init . envrc-global-mode))
