;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)

;;关闭自动备份文件
(setq make-backup-files nil)

;;输入替换选中文本
(delete-selection-mode 1)

;;开启自动括号匹配
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; 设置垃圾回收，在 Windows 下，emacs25 版本会频繁出发垃圾回收，所以需要设置 
(when (eq system-type 'windows-nt) 
(setq gc-cons-threshold (* 512 1024 1024)) 
(setq gc-cons-percentage 0.5) 
(run-with-idle-timer 5 t #'garbage-collect) 
;; 显示垃圾回收信息，这个可以作为调试用;; 
(setq garbage-collection-messages t)) 

(provide 'init-better-defaults)
