;; emacs config entry
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Package Management
;; -----------------------------------------------------------------
(require 'init-packages)
(require 'init-ui)
(require 'init-better-defaults)
(require 'init-keybindings)
(require 'init-org)
(require 'my-custom)
(require 'init-helper)





;;define a function to open config file
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;;set open config file to shortcut open-init-file <f5> 
(global-set-key (kbd "<f5>") 'open-init-file)
