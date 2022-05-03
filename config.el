;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Thales Loreto"
      user-mail-address "tloreto.dev@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Iosevka SS04" :size 16 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-solarized-dark)
;; Change the Dashboard
(setq fancy-splash-image "~/.doom.d/splash/emacs-dash.png")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(after! org
  (setq org-directory "~/Documents/org/")
  (setq org-log-done 'time)

  (setq org-agenda-files
        '("~/Documents/org/agenda.org"))

  (require 'org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; osx keys
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)

;; Checkers configs
;; Disable the LSP Format on Save
;; disable this for use the Flycheck formatter
(setq +format-with-lsp nil)

;; Force typescript indent level to 2
(after! typescript-mode
  (setq typescript-indent-level 2))

;; Discord rich presence
(setq elcord--editor-name "Emacs")
(setq elcord-editor-icon "emacs_icon")
(elcord-mode 1)

;; C/C++ lsp settings
(after! ccls
  (setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t)))
  (set-lsp-priority! 'ccls 2)) ; optional as ccls is the default in Doom

;; Add elisp-lsp when open any Elixir file
(use-package lsp-mode
  :commands lsp
  :ensure t
  :diminish lsp-mode
  :hook
  (elixir-mode . lsp)
  :init
  (add-to-list 'exec-path "~/.emacs.d/.local/etc/lsp/elixir-ls/release")
  (setq lsp-elixir-suggest-specs nil))

;; React Highlight (tree-sitter)
(use-package! typescript-mode
  :init
  (define-derived-mode typescript-tsx-ts-mode typescript-mode "typescript-tsx")
  (add-to-list 'auto-mode-alist (cons (rx ".tsx" string-end) #'typescript-tsx-ts-mode))
  t)

(add-hook! typescript-tsx-ts-mode 'lsp!)

(use-package! tree-sitter
  :hook (prog-mode . turn-on-tree-sitter-mode)
  :hook (tree-sitter-after-on . tree-sitter-hl-mode)
  :config
  (require 'tree-sitter-langs)

  (tree-sitter-require 'tsx)
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescript-tsx-ts-mode . tsx))

  ;; This makes every node a link to a section of code
  (setq tree-sitter-debug-jump-buttons t
        ;; and this highlights the entire sub tree in your code
        tree-sitter-debug-highlight-jump-region t))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
