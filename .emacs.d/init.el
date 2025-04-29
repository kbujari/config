(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(when (version< emacs-version "27")
  (package-initialize)
  (load (concat user-emacs-directory "early-init.el")))

(setq inhibit-startup-message t
      inhibit-splash-screen t
      blink-cursor-mode 0
      use-file-dialog nil
      display-line-numbers-type 'relative)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

(global-display-line-numbers-mode +1)
(set-default-coding-systems 'utf-8)

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

(use-package nix-mode :ensure t
  :mode "\\.nix\\'")

(use-package rust-mode :ensure t)

(use-package magit
  :ensure t)

(use-package eglot :ensure t
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
