(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

(when (< emacs-major-version 27)
  (package-initialize)
  (load (concat user-emacs-directory "early-init.el")))

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
      display-line-numbers-type 'relative
      font-lock-maximum-decoration 0
      scroll-preserve-screen-position t)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

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

(deftheme quiet "Simple white-on-black theme"
          :background-mode 'dark
          :kind 'color-scheme)

(let ((quiet-bg "#282828")
      (quiet-fg "#ebdbb2")
      (quiet-fg-dim "#ffaf00")
      (quiet-const "#999999")
      (quiet-error "#ff003f"))

  ;; M-x list-faces-display for face identifiers
  ;; C-h f set-face-attribute for face modifications
  (custom-theme-set-faces
   'quiet
   `(default ((t (:background ,quiet-bg :foreground ,quiet-fg))))
   `(fringe ((t (:background ,quiet-bg :foreground ,quiet-fg))))
   `(cursor ((t (:background ,quiet-fg :inverse-video t))))
   `(vertical-border ((t (:foreground ,quiet-fg-dim))))
   `(minibuffer-prompt ((t (:foreground ,quiet-fg :weight bold))))
   `(mode-line ((t (:background ,quiet-fg :foreground ,quiet-bg :box ,quiet-fg))))
   `(mode-line-inactive ((t (:background ,quiet-fg-dim :foreground ,quiet-bg :box ,quiet-fg-dim))))

   `(envrc-mode-line-none-face ((t (:foreground ,quiet-bg))))
   `(envrc-mode-line-on-face ((t (:foreground ,quiet-bg))))
   `(envrc-mode-line-error-face ((t (:foreground ,quiet-bg))))

   `(font-lock-builtin-face ((t (:foreground ,quiet-fg))))
   `(font-lock-comment-face ((t (:foreground ,quiet-fg-dim :slant italic))))
   `(font-lock-constant-face ((t (:foreground ,quiet-const))))
   `(font-lock-function-call-face ((t (:foreground ,quiet-fg))))
   `(font-lock-function-name-face ((t (:foreground ,quiet-fg))))
   `(font-lock-keyword-face ((t (:foreground ,quiet-fg :weight bold))))
   `(font-lock-preprocessor-face ((t (:foreground ,quiet-fg))))
   `(font-lock-property-name-face ((t (:foreground ,quiet-fg))))
   `(font-lock-property-use-face ((t (:foreground ,quiet-fg))))
   `(font-lock-string-face ((t (:foreground ,quiet-const))))
   `(font-lock-type-face ((t (:foreground ,quiet-fg))))
   `(font-lock-variable-name-face ((t (:foreground ,quiet-fg))))
   `(font-lock-variable-use-face ((t (:foreground ,quiet-fg))))

   `(tuareg-font-lock-governing-face ((t (:foreground ,quiet-fg :weight bold))))

   `(line-number ((t (:foreground "#585858"))))
   `(show-paren-match ((t (:foreground "#ff00af" :weight bold))))
   `(show-paren-mismatch ((t (:background ,quiet-error))))
   `(highlight ((t (:background "#303030"))))
   `(fill-column-indicator ((t (:height 1 :background ,quiet-fg-dim :foreground ,quiet-fg-dim))))
   `(region ((t (:background "#ffaf00" :foreground ,quiet-bg))))))

(enable-theme 'quiet)

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

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)))

;; (use-package evil :ensure t
;;   :init
;;   (setq evil-want-C-u-scroll t)
;;   :hook
;;   (prog-mode . turn-on-evil-mode)
;;   (text-mode . turn-on-evil-mode))

(use-package meow
  :ensure t
  :config
  (meow-setup)
  (meow-global-mode 1))

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

(use-package kdl-mode
  :ensure t
  :mode "\\.kdl\\'")

(use-package magit
  :ensure t)

(use-package eglot
  :ensure t
  :hook ((rust-mode nix-mode tuareg-mode) . eglot-ensure)
  :custom
  (eglot-ignored-server-capabilities '(:inlayHintProvider))
  :bind (:map eglot-mode-map
         ("C-c c a" . eglot-code-actions)
         ("C-c c r" . eglot-rename)
         ("C-c c f" . eglot-format)
         ("C-c c b" . eglot-format-buffer)
         ("C-c c i" . eglot-find-implementation)
         ("C-c c d" . eglot-find-declaration)
         ("C-c c t" . eglot-find-typeDefinition)
         ("C-c c z" . eglot-reconnect)))

(use-package envrc
  :ensure t
  :hook (after-init . envrc-global-mode))
