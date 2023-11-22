(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 14))

(setq doom-theme 'doom-tokyo-night)

(setq display-line-numbers-type 'relative)

(setq org-directory "~/org/")

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(setq-default
 frame-title-format
 '(:eval (format "[%%b%s] - %s"
                 (if (buffer-modified-p)
                     " •"
                   "")
                 system-name)))

(global-subword-mode 1)

(add-hook! 'text-mode (lambda () (auto-revert-mode 1)))

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(setq evil-disable-insert-state-bindings t)

(map! :after evil :gnvi "C-f" #'consult-line)

(when (version< "29.0.50" emacs-version)
  (pixel-scroll-precision-mode))

(after! marginalia
  (setq marginalia-censor-variables nil)

  (defadvice! +marginalia--anotate-local-file-colorful (cand)
    "Just a more colourful version of `marginalia--anotate-local-file'."
    :override #'marginalia--annotate-local-file
    (when-let (attrs (file-attributes (substitute-in-file-name
                                       (marginalia--full-candidate cand))
                                      'integer))
      (marginalia--fields
       ((marginalia--file-owner attrs)
        :width 12 :face 'marginalia-file-owner)
       ((marginalia--file-modes attrs))
       ((+marginalia-file-size-colorful (file-attribute-size attrs))
        :width 7)
       ((+marginalia--time-colorful (file-attribute-modification-time attrs))
        :width 12))))

  (defun +marginalia--time-colorful (time)
    (let* ((seconds (float-time (time-subtract (current-time) time)))
           (color (doom-blend
                   (face-attribute 'marginalia-date :foreground nil t)
                   (face-attribute 'marginalia-documentation :foreground nil t)
                   (/ 1.0 (log (+ 3 (/ (+ 1 seconds) 345600.0)))))))
      ;; 1 - log(3 + 1/(days + 1)) % grey
      (propertize (marginalia--time time) 'face (list :foreground color))))

  (defun +marginalia-file-size-colorful (size)
    (let* ((size-index (/ (log10 (+ 1 size)) 7.0))
           (color (if (< size-index 10000000) ; 10m
                      (doom-blend 'orange 'green size-index)
                    (doom-blend 'red 'orange (- size-index 1)))))
      (propertize (file-size-human-readable size) 'face (list :foreground color)))))

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)

(after! doom-modeline
  (setq all-the-icons-scale-factor 1.1
        auto-revert-check-vc-info t
        doom-modeline-major-mode-icon (display-graphic-p)
        doom-modeline-major-mode-color-icon (display-graphic-p)
        doom-modeline-buffer-file-name-style 'relative-to-project
        doom-modeline-github t
        doom-modeline-github-interval 60
        doom-modeline-vcs-max-length 60)
  (remove-hook 'doom-modeline-mode-hook #'size-indication-mode)
  (doom-modeline-def-modeline 'main
    '(bar modals workspace-name window-number persp-name buffer-position selection-info buffer-info matches remote-host debug vcs matches)
    '(github mu4e grip gnus checker misc-info repl lsp " ")))

(custom-theme-set-faces! 'doom-nord
  `(tree-sitter-hl-face:constructor :foreground ,(doom-color 'blue))
  `(tree-sitter-hl-face:number :foreground ,(doom-color 'magenta))
  `(tree-sitter-hl-face:attribute :foreground ,(doom-color 'magenta) :weight bold)
  `(tree-sitter-hl-face:variable :foreground ,(doom-color 'base7) :weight bold)
  `(tree-sitter-hl-face:variable.builtin :foreground ,(doom-color 'base7) :weight bold)
  `(tree-sitter-hl-face:constant.builtin :foreground ,(doom-color 'magenta) :weight bold)
  `(tree-sitter-hl-face:constant :foreground ,(doom-color 'teal) :weight bold)
  `(tree-sitter-hl-face:function.macro :foreground ,(doom-color 'teal))
  `(tree-sitter-hl-face:label :foreground ,(doom-color 'magenta))
  `(tree-sitter-hl-face:operator :foreground ,(doom-color 'blue))
  `(tree-sitter-hl-face:variable.parameter :foreground ,(doom-color 'dark-blue))
  `(tree-sitter-hl-face:punctuation.delimiter :foreground ,(doom-color 'cyan))
  `(tree-sitter-hl-face:punctuation.bracket :foreground ,(doom-color 'cyan))
  `(tree-sitter-hl-face:punctuation.special :foreground ,(doom-color 'cyan))
  `(tree-sitter-hl-face:type :foreground ,(doom-color 'blue))
  `(tree-sitter-hl-face:type.builtin :foreground ,(doom-color 'blue))
  `(tree-sitter-hl-face:tag :foreground ,(doom-color 'base7))
  `(tree-sitter-hl-face:string :foreground ,(doom-color 'green))
  `(tree-sitter-hl-face:comment :foreground ,(doom-color 'base6))
  `(tree-sitter-hl-face:function :foreground ,(doom-color 'cyan))
  `(tree-sitter-hl-face:method :foreground ,(doom-color 'teal))
  `(tree-sitter-hl-face:function.builtin :foreground ,(doom-color 'cyan))
  `(tree-sitter-hl-face:property :foreground ,(doom-color 'dark-blue))
  `(tree-sitter-hl-face:keyword :foreground ,(doom-color 'blue))
  `(corfu-default :font "JetBrainsMono Nerd Font" :background ,(doom-color 'bg-alt) :foreground ,(doom-color 'fg))
  `(adoc-title-0-face :foreground ,(doom-color 'blue) :height 1.2)
  `(adoc-title-1-face :foreground ,(doom-color 'magenta) :height 1.1)
  `(adoc-title-2-face :foreground ,(doom-color 'violet) :height 1.05)
  `(adoc-title-3-face :foreground ,(doom-lighten (doom-color 'blue) 0.25) :height 1.0)
  `(adoc-title-4-face :foreground ,(doom-lighten (doom-color 'magenta) 0.25) :height 1.1)
  `(adoc-verbatim-face :background nil)
  `(adoc-list-face :background nil)
  `(adoc-internal-reference-face :foreground ,(face-attribute 'font-lock-comment-face :foreground)))

(when (string= "" (shell-command-to-string "pgrep awesome"))
  (add-to-list 'default-frame-alist '(fullscreen . maximized)))
