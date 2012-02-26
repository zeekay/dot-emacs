;; Hide shit on startup
(setq inihibit-startup-screen t)
(setq vc-follow-symlinks t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Basic
(setq scroll-step 1)
(setq-default indent-tabs-mode nil)
;; (set-default-font "MonteCarlo:pixelsize=11:foundry=Bok:weight=normal:slant=normal:width=normal:spacing=100:scalable=false")
(set-default-font "Inconsolata:pixelsize=14")
(setq visible-cursor nil)
(setq cursor-in-non-selected-windows nil)
(fset 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)

;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  ;; (setq mac-command-key-is-meta t)
  ;; (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char)) ;; sets fn-delete to be right-delete

;; Autosave/Backups
(setq make-backup-files t)
(setq version-control t)
(setq backup-directory-alist '((".*" . "~/.emacs/backups")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs/autosaves/\\1" t)))

(custom-set-variables
 '(inhibit-startup-screen t))

; derived from ELPA installation
; http://tromey.com/elpa/install.html
(defun eval-url (url)
  (let ((buffer (url-retrieve-synchronously url)))
  (save-excursion
    (set-buffer buffer)
    (goto-char (point-min))
    (re-search-forward "^$" nil 'move)
    (eval-region (point) (point-max))
    (kill-buffer (current-buffer)))))

;; Load ELPA
(add-to-list 'load-path "~/.emacs.d/elpa")

(defun install-elpa ()
  (eval-url "http://tromey.com/elpa/package-install.el"))

(if (require 'package nil t)
    (progn
        (setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                                 ("marmalade" . "http://marmalade-repo.org/packages/")))
        (package-initialize))
  (install-elpa))

;; Marmalade package archive
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;; Load el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(defun install-el-get ()
  (eval-url
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"))

(unless (require 'el-get nil t)
  (install-el-get))

;; extra recipes for packages unknown to el-get (yet)
(setq el-get-sources
      '((:name css-mode :type elpa)
        (:name js2-mode-mooz
               :type git
               :url "git://github.com/mooz/js2-mode.git"
               :load "js2-mode.el"
               :compile ("js2-mode.el")
               :features js2-mode)))

;; list all packages you want installed
(setq my-el-get-packages
      (append
       '(evil color-theme js2-mode-mooz python-mode
              haskell-mode haml-mode clojure-mode
              coffee-mode undo-tree)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-el-get-packages)

(require 'coffee-mode)
(require 'python-mode)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; Evil
(setq evil-move-cursor-back nil)
(setq evil-default-cursor t)

(require 'evil)
(evil-mode 1)
;; Remap org-mode meta keys for convenience
(mapcar (lambda (state)
    (evil-declare-key state org-mode-map
      (kbd "M-l") 'org-metaright
      (kbd "M-h") 'org-metaleft
      (kbd "M-k") 'org-metaup
      (kbd "M-j") 'org-metadown
      (kbd "M-L") 'org-shiftmetaright
      (kbd "M-H") 'org-shiftmetaleft
      (kbd "M-K") 'org-shiftmetaup
      (kbd "M-J") 'org-shiftmetadown))
  '(normal insert))

;; Colors
(add-to-list 'load-path "~/.emacs.d/colors")

(require 'color-theme)
(require 'color-theme-gruber-darker)
(color-theme-gruber-darker)
;; (require 'color-theme-almost-monokai)
;; (color-theme-almost-monokai)

;; Python
(add-hook 'before-save-hook 'delete-trailing-whitespace)
