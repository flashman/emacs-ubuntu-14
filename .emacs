;;melpa repo
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (manoj-dark)))
 '(fill-column 100)
 '(jde-jdk-registry (quote (("1.7" . "/usr/lib/jvm/java-7-openjdk-amd64") ("1.7" . "/usr/lib/jvm/java-7-oracle"))))
 '(show-paren-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify))))

;;transparency
(set-frame-parameter (selected-frame) 'alpha '(85 50))
(add-to-list 'default-frame-alist '(alpha 95 50))

;; Set default load path
(add-to-list 'load-path "~/.emacs.d/")

;; Spell check
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(autoload 'flyspell-delay-command "flyspell" "Delay on command." t)
(autoload 'tex-mode-flyspell-verify "flyspell" "" t)

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(global-set-key (kbd "<f8>") 'ispell-word)

(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word))
(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)

(eval-after-load "flyspell"
    '(progn
       (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
       (define-key flyspell-mouse-map [mouse-3] #'undefined)))

;; Elpy
(package-initialize)
(elpy-enable)

;; Yasnipit
(require 'yasnippet)
(yas-global-mode 1)

;; Autocomplete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/flash/.emacs.d//ac-dict")
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;; Automatic comment wrapping
(require 'newcomment)
;;(setq comment-auto-fill-only-comments t)
(setq-default auto-fill-function 'do-auto-fill)
(setq-default fill-column 80)

;; Show column number
(setq column-number-mode t)

;; electric-indent
(electric-indent-mode +1)

;; web-mode
(add-to-list 'auto-mode-alist '("\\.html.erb\\'" . web-mode))

;; ruby-end
(eval-after-load "ruby-mode"
  '(add-hook 'ruby-mode-hook 'ruby-end-mode))


;; This Rsense stuff needs to go at the end as there is apperently
;; some wierd issue with compilation.

;; Rsense
(setq rsense-home "/home/flash/opt/rsense-0.3")
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)

;; Rsense + Autocomplete
(add-hook 'ruby-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-rsense-method)
            (add-to-list 'ac-sources 'ac-source-rsense-constant)))
(put 'upcase-region 'disabled nil)


;; Auto complete java
(add-to-list 'load-path "~/.emacs.d/ajc-java-complete/")
(require 'ajc-java-complete-config)
(add-hook 'java-mode-hook 'ajc-java-complete-mode)
(add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)
(setq ajc-tag-file-list (list (expand-file-name "~/.java_base.tag")))
(setq ajc-use-plain-method-completion t)

;; Set code style params
;; ======================
;; Always use spaces for line offset
(setq-default indent-tabs-mode nil)

(setq-default tab-width 2)
(setq-default c-basic-offset 2)

;; Delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; C/Java styling
(defun my-style-setup ()
  (interactive)

  ;; Basic indent is 8 spaces
  (make-local-variable 'c-basic-offset)
  (setq c-basic-offset 2)

  (c-set-offset 'arglist-intro 4)
  (c-set-offset 'arglist-cont 0)
  (c-set-offset 'arglist-cont-nonempty 4)
  (c-set-offset 'statement-cont 4))

(add-hook 'c-mode-common-hook 'my-style-setup)
(add-hook 'java-mode-hook 'my-style-setup)

;; Javascript style conventions (same as Java)
(setq-default js-indent-level 2)

;; Python styling
(defun my-python-style-setup ()
  (setq python-indent-offset 4)
  (electric-indent-mode 0))

(add-hook 'python-mode-hook 'my-python-style-setup)
