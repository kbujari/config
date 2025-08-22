;; Always load newest byte code
(setopt load-prefer-newer t)

;; Reduce frequency of garbage collection
(setopt gc-cons-threshold (* 128 1024 1024))

;; Tune processes for better performance
(setopt read-process-output-max (* 4 1024 1024)
        process-adaptive-read-buffering nil)

;; Define file for all custom configuration
(setopt custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;; Remove extraneous UI elements
(setopt inhibit-startup-message t
        inhibit-splash-screen t
        use-file-dialog nil)

;; Insert tabs as spaces, render tabs as 2 spaces
(setopt indent-tabs-mode nil
        tab-width 2)

;; Disable emacs generated files (.#emacsa8932) (#file#) (file~)
(setopt create-lockfiles nil
        auto-save-default nil
        make-backup-files nil)

(require 'package)

(add-to-list 'package-archives
             '("MELPA"  . "https://melpa.org/packages/")
             '("NONGNU" . "https://elpa.nongnu.org/nongnu/"))

(package-initialize)

(when (fboundp 'display-line-numbers-mode)
  (setopt display-line-numbers-width 3)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode))

(when (boundp 'display-fill-column-indicator)
  (setopt indicate-buffer-boundaries 'left
          display-fill-column-indicator-character ?┊)
  (add-hook 'prog-mode-hook 'display-fill-column-indicator-mode))

(when (fboundp 'show-paren-mode)
  (setopt show-paren-delay 0)
  (add-hook 'prog-mode-hook 'show-paren-mode))

(when (fboundp 'repeat-mode)
  (add-hook 'after-init-hook 'repeat-mode))

;; General editor preferences
(setopt column-number-mode t
        case-fold-search t
        scroll-preserve-screen-position 'always
        truncate-lines nil
        truncate-partial-width-windows nil
        buffers-menu-max-size 30)

;; Deletes selection when typing
(add-hook 'after-init-hook 'delete-selection-mode)

;; Update buffers when they change from outside emacs
(when (fboundp 'global-auto-revert-mode)
  (setopt global-auto-revert-non-file-buffers t
          auto-revert-verbose nil)
  (add-hook 'after-init-hook 'global-auto-revert-mode))

(when (fboundp 'which-key-mode)
  (add-hook 'after-init-hook 'which-key-mode))

(add-hook 'before-save-hook #'delete-trailing-whitespace)

(when (member "Iosevka" (font-family-list))
  (set-face-attribute 'default nil :font "Iosevka" :height 124)
  (set-face-attribute 'fixed-pitch nil :family "Iosevka"))

(deftheme quiet "Simple white-on-black theme"
          :background-mode 'dark
          :kind 'color-scheme)

(let ((quiet-bg "#181616")
      (quiet-fg "#c5c9c5")
      (quiet-fg-dim "#707070")
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
   `(Font-lock-variable-name-face ((t (:foreground ,quiet-fg))))
   `(font-lock-variable-use-face ((t (:foreground ,quiet-fg))))

   `(tuareg-font-lock-governing-face ((t (:foreground ,quiet-fg :weight bold))))

   `(line-number ((t (:foreground "#585858"))))
   `(show-paren-match ((t (:foreground "#ff00af" :weight bold))))
   `(show-paren-mismatch ((t (:background ,quiet-error))))
   `(highlight ((t (:background "#303030"))))
   `(fill-column-indicator ((t (:height 1 :background ,quiet-fg-dim :foreground ,quiet-fg-dim))))
   `(region ((t (:background "#ffaf00" :foreground ,quiet-bg))))))

;; (enable-theme 'quiet)

(use-package mu4e
  :ensure nil
  :custom
  (setq mu4e-get-mail-command "mbsync -a"
        message-kill-buffer-on-exit t ;; don't keep message buffers
        mu4e-confirm-quit nil         ;; don't ask to quit
        mu4e-change-filenames-when-moving t))

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

(use-package ef-themes
  :ensure t
  :config
  (load-theme 'ef-dream t))

(use-package meow
  :ensure t
  :config
  (setq meow-use-clipboard t)
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
  :mode ("\\.\\(ml[dipy]?\\)\\'" . tuareg-mode))

(use-package dune
  :ensure t
  :after tuareg)

(use-package haskell-mode
  :ensure t
  :mode "\\.hs\\'")

(use-package erlang
  :ensure t
  :mode "\\.[eh]rl\\'")

(use-package typst-ts-mode
  :ensure t
  :mode "\\.typ\\'")

(use-package geiser
  :ensure t)

(use-package geiser-guile
  :ensure t)

(use-package paredit
  :ensure t
  :hook ((emacs-lisp-mode
          eval-expression-minibuffer-setup-mode
          lisp-mode
          lisp-interaction-mode
          ielm-mode
          scheme-mode)
         . enable-paredit-mode))

(use-package kdl-mode
  :ensure t
  :mode "\\.kdl\\'")

(use-package magit
  :ensure t)

(use-package eglot
  :hook ((rust-mode
          nix-mode
          tuareg-mode
          haskell-mode
          erlang-mode
          typst-ts-mode)
         . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(erlang-mode . ("elp" "server")))

  (setq eglot-ignored-server-capabilities '(:inlayHintProvider))
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
