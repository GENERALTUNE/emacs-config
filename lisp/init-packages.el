;; package config 
 (when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (add-to-list  'package-archives '("melpa" . "http://elpa.emacs-china.org/melpa/") t))
;;     (add-to-list  'package-archives '("melpa" . "http://melpa.org/packages/") t))
;;("gnu"   . "http://elpa.emacs-china.org/gnu/")

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

 ;; cl - Common Lisp Extension
(require 'cl)

 ;; Add Packages
 (defvar generaltune/packages '(
                ;; --- Auto-completion ---
                company
                ;; --- Better Editor ---
		hungry-delete
                swiper
                counsel
                smartparens
                iedit
		popwin
		smex
		swiper
                counsel
                ;; --- Major Mode ---
                js2-mode
	        web-mode
;; --- Minor Mode ---
                nodejs-repl
;;        exec-path-from-shell
;; --- Themes ---
                monokai-theme
;;                  spacemacs-theme
;;                solarized-theme
                ) "Default packages")



 (defun generaltune/packages-installed-p ()
     (loop for pkg in generaltune/packages
           when (not (package-installed-p pkg)) do (return nil)
           finally (return t)))

 (unless (generaltune/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg generaltune/packages)
       (when (not (package-installed-p pkg))
         (package-install pkg)))) 

;;config for smex
(require 'smex)  ;; Not need if you use package.el
(smex-initialize) ;; Can be omitted. This might cause a (minimal) delay 
;;(global-set-key (kbd "M-x") 'smex)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

;; 开启全局 Company 补全
(global-company-mode 1)
;;(with-eval-after-load 'company
;;  (define-key company-active-map (kbd "M-n") nil) 
;;  (define-key company-active-map (kbd "M-p") nil)
;;  (define-key company-active-map (kbd "C-n") #'company-select-next)
;;  (define-key company-active-map (kbd "C-p") #'company-select-previous))

;; 开启主题
(load-theme 'monokai t)
;;(load-theme 'spacemacs t)

;;最近打开文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 20)

;; 这个快捷键绑定可以用之后的插件 counsel 代替
(global-set-key (kbd "C-c C-l") 'recentf-open-files)

;;config hungry-delete-
(require 'hungry-delete)
(global-hungry-delete-mode)

;;smartparent
(require 'smartparens-config)
;;(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t) ;;全局开启smartparent mode
;;
;;(ivy-mode 1)
;;(setq ivy-use-virtual-buffers t)
;;(setq enable-recursive-minibuffers t)
;;(global-set-key "\C-s" 'swiper)
;;(global-set-key (kbd "C-c C-r") 'ivy-resume)
;;(global-set-key (kbd "<f6>") 'ivy-resume)
;;(global-set-key (kbd "M-x") 'counsel-M-x)
;;(global-set-key (kbd "C-x C-f") 'counsel-find-file)

;; popwin config
(require 'popwin)
(popwin-mode 1)

;;iedit  多点编辑
(require 'iedit)


;;config for javascript files 

(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)

(defun my-toggle-web-indent ()
  (interactive)
;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
        (setq js-indent-level (if (= js-indent-level 2) 4 2))
        (setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))

  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
             (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
             (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))

  (setq indent-tabs-mode nil))

(global-set-key (kbd "C-c t i") 'my-toggle-web-indent)


;;文件模式 匹配
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       '(("\\.html\\'" . web-mode))
       '(("\\.vm\\'" . web-mode))
       auto-mode-alist))

(add-hook 'js-mode-hook
        (lambda ()
;;        (define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-sexp)
        (define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-buffer)
      (define-key js-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
    (define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
  (define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)))


(provide 'init-packages)
