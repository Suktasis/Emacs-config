;; MELPA
(require 'package)


(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/plugins")

;; org

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (undo-tree yasnippet auto-complete org-edna)))
 '(speedbar-show-unknown-files t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)


;; ergoemacs
(add-to-list 'load-path "~/.emacs.d/ergoemacs-mode")
(require 'ergoemacs-mode)

(setq ergoemacs-theme nil) ;; Uses Standard Ergoemacs keyboard theme
(setq ergoemacs-keyboard-layout "us") ;; Assumes QWERTY keyboard layout
(ergoemacs-mode 1)


;; noconfirm update

(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive)
    (revert-buffer :ignore-auto :noconfirm))

(global-set-key "\C-r" 'revert-buffer-no-confirm)

;; auto-complete for C++

(add-hook 'c++-mode-hook
      (lambda()
            (semantic-mode 1)
            (define-key c++-mode-map (kbd "C-q") 'c++-auto-complete)))

(defun c++-auto-complete ()
  (interactive)
  (let ((ac-sources
         `(ac-source-semantic
           ,@ac-sources)))
    (auto-complete)))

(setq ac-modes '(c++-mode c-mode python-mode))


;; hide bars and get rid of backups, begin with scratch

(menu-bar-mode -1)
(tool-bar-mode -1)

(setq make-backup-files         nil) ; Don't want any backup files
(setq auto-save-list-file-name  nil) ; Don't want any .saves files
(setq auto-save-default nil) ; Don't want any auto saving
(setq inhibit-startup-screen t)


;; https://www.emacswiki.org/emacs/download/linum%2b.el
(require 'linum+)
(setq linum-format "%d ")
(global-linum-mode 1)

;; ido-mode, shall get back here later

;;(require 'ido)
;;(ido-mode t)
;;(setq ido-enable-flex-matching t)

;; hs-minor-mode

(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key "\C-cs" 'hs-show-block)
(global-set-key "\C-ch" 'hs-hide-block)
(global-set-key "\M-q" 'kill-region)

;; bs, embedded

(require 'bs)
(setq bs-configurations
      '(("files" "^\\*scratch\\*" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)))

(global-set-key (kbd "<f2>") 'bs-show)

;; https://www.emacswiki.org/emacs/SrSpeedbar

(require 'sr-speedbar)

(global-set-key (kbd "<f12>") 'sr-speedbar-toggle)

;; https://www.emacswiki.org/emacs/Yasnippet


(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)



(global-set-key (kbd "<f10>") 'yas-new-snippet)








;; compile kbd

(global-set-key "\M-[" 'compile)
(global-set-key "\M-]" 'kill-compilation)


;; TRAMP (sudo)


(require 'tramp)


;; Theme http://www.nongnu.org/color-theme/

(add-to-list 'load-path "/usr/share/emacs/site-lisp/color-theme")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
(zenburn-theme )))
