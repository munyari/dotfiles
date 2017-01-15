(load-file "~/.emacs.d/sensible-defaults.el")
(sensible-defaults/use-all-settings)
(sensible-defaults/use-all-keybindings)

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;;(add-to-list 'package-archives '("melpa" .
;;                                "http://stable.melpa.org/packages/"))
(package-initialize)
(require 'evil)
(evil-mode 1)

(defun ensure-package-installed (&rest packages)
  " Assure every package is installed, ask for installation if it's not.

  Return a list of installed packages of nil for every skipped package."
  (mapcar
    (lambda (package)
      (if (package-installed-p package)
        nil
        (if (y-or-n-p (format "Package %s is missing. Install it? " package))
          (package-install package)
          package)))
    packages))

;; Make sure to have downloaded archive description
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

;; Install these packages
(ensure-package-installed 'magit
                          'evil
                          'relative-line-numbers
                          'gotham-theme
                          'powerline)

(global-relative-line-numbers-mode)

;; load theme without enabling it yet
(load-theme 'gotham t)
;; enable theme
(enable-theme 'gotham)
(powerline-default-theme)
