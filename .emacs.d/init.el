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

(load-theme 'modus-vivendi t)

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
      compilation-scroll-output t)

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

;;; Minibuffer and completions

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
  (dired-mode . hl-line-mode)
  :config
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-dwim-target t))

(use-package htmlize :ensure t)
(require 'ox-publish)
(setq blog-org-files-dir "~/org/")
(defvar html-head
  "<link rel=\"stylesheet\" href=\"/main.css\" type=\"text/css\">")

(defvar html-preamble
  "<header style=\" margin: 3em 0 3em 0; display: flex; gap: 8px; flex-direction: column; font-family: monospace;\">
        <span>
            Kleidi Bujari <<a href=\"mailto:mail@4kb.net\">mail@4kb.net</a>>
        </span>
        <nav style=\"display: flex; gap: 8px\">
            <span><a href=\"/\">kleidi.ca</a> |</span>
            <a href=\"/about.html\">about</a>
            <a target=\"_blank\" href=\"https://github.com/kbujari\">git</a>
            <a href=\"/feed.xml\">rss</a>
        </nav>
    </header>")

(defun kleidi/org-sitemap-format-entry (entry style project)
  "Format ENTRY in org-publish PROJECT."
  (let ((filetitle (org-publish-find-title entry project)))
    (if (= (length filetitle) 0)
        (format "[[file:%sindex.html][*%s*]]" entry entry)
      (format "%s [[file:%s][%s]]"
              (format-time-string "%Y-%m-%d"
                                  (org-publish-find-date entry project))
              entry
              filetitle))))

(setq org-publish-project-alist
      `(("pages"
         :base-directory ,blog-org-files-dir
         :base-extension "org"
         :recursive t
         :publishing-directory "~/public_html/"
         :publishing-function org-html-publish-to-html
         :auto-sitemap t
         :sitemap-title nil
         :sitemap-filename "index.org"
         :sitemap-sort-files chronologically
         :sitemap-format-entry kleidi/org-sitemap-format-entry
         :html-head-include-default-style nil
         :html-postamble nil
         :html-head ,html-head
         :html-preamble ,html-preamble)

        ("css"
         :base-directory ,blog-org-files-dir
         :base-extension "css"
         :publishing-directory "~/public_html/"
         :publishing-function org-publish-attachment)

        ("kleidi.ca"
         :components ("pages" "css"))))

;;; Languages

(use-package nix-ts-mode
  :ensure t
  :mode "\\.nix\\'")

(use-package rust-mode
  :ensure t
  :init
  (setq rust-mode-treesitter-derive t))

(use-package tuareg
  :ensure t)

(use-package dune :ensure t)

(use-package merlin
  :ensure t
  :config
  (add-hook 'tuareg-mode-hook #'merlin-mode))

(use-package utop
  :ensure t
  :config
  (add-hook 'tuareg-mode-hook #'utop-minor-mode))

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
  :hook
  (rust-mode . eglot-ensure)
  (nix-mode . eglot-ensure)
  (tuareg-mode . eglot-ensure))

(use-package envrc
  :ensure t
  :hook (after-init . envrc-global-mode))
