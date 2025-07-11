(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

(when (< emacs-major-version 27)
  (package-initialize)
  (load (concat user-emacs-directory "early-init.el")))

(load-theme 'modus-vivendi t)

(require 'package)

(add-to-list 'package-archives
             '("MELPA"  . "https://melpa.org/packages/")
             '("NONGNU" . "https://elpa.nongnu.org/nongnu/"))

(package-initialize)

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

;; (global-hl-line-mode +1)
(global-display-line-numbers-mode +1)
(global-display-fill-column-indicator-mode 1)
;; (global-font-lock-mode 0) ; Disable syntax highlighting
(set-default-coding-systems 'utf-8)

(show-paren-mode 1)
(setq show-paren-delay 0)

(when (fboundp 'which-key-mode)
  (which-key-mode 1))

(when (member "Iosevka" (font-family-list))
  (set-face-attribute 'default nil :font "Iosevka" :height 124)
  (set-face-attribute 'fixed-pitch nil :family "Iosevka"))

(add-hook 'before-save-hook #'delete-trailing-whitespace)
(add-hook 'prog-mode-hook #'hl-line-mode)

(use-package mu4e
  :ensure nil
  :config
  (setq mu4e-get-mail-command "mbsync -a"
        message-kill-buffer-on-exit t ;; don't keep message buffers
        mu4e-confirm-quit nil ;; don't ask to quit
        mu4e-change-filenames-when-moving t))

(use-package eat
  :ensure t)


(use-package evil :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  :hook
  (prog-mode . turn-on-evil-mode)
  (text-mode . turn-on-evil-mode))

(use-package vertico
  :ensure t
  :hook after-init
  :custom
  (vertico-cycle t))

(use-package marginalia
  :ensure t
  :hook after-init)

(use-package orderless
  :ensure t
  :after vertico
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

(use-package corfu
  :ensure t
  :hook (after-init . global-corfu-mode)
  :config
  (keymap-unset corfu-map "RET"))

(use-package dired
  :ensure nil
  :commands (dired)
  :hook
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :custom
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'always)
  (delete-by-moving-to-trash t)
  (dired-dwim-target t))

(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'")

(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'")

(use-package tuareg
  :ensure t
  :mode ("\\(ml[ipy]?\\)\\'" . tuareg-mode))

(use-package dune
  :ensure t
  :after tuareg)

(use-package merlin
  :ensure t
  :hook tuareg-mode)

(use-package utop
  :ensure t
  :hook (tuareg-mode . utop-minor-mode))

(use-package geiser
  :ensure t)

(use-package geiser-guile
  :ensure t)

(use-package magit
  :ensure t)

(use-package eglot
  :ensure t
  :bind (("M-TAB" . completion-at-point)
         :map eglot-mode-map
         ("C-c c a" . eglot-code-actions)
         ("C-c c r" . eglot-rename)
         ("C-c c f" . eglot-format))
  :hook ((rust-mode nix-mode tuareg-mode) . eglot-ensure))

(use-package envrc
  :ensure t
  :hook (after-init . envrc-global-mode))
