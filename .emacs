(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;auto indent
(add-hook 'c-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'c-mode-hook (lambda () (setq comment-column 48) ))
(add-hook 'c++-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'c++-mode-hook (lambda () (setq comment-column 48) ))
(add-hook 'java-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'java-mode-hook (lambda () (setq comment-column 48) ))
(add-hook 'ruby-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'ruby-mode-hook (lambda () (setq comment-column 48) ))
(add-hook 'python-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'python-mode-hook (lambda () (setq comment-column 48) ))
(add-hook 'scheme-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'scheme-mode-hook (lambda () (setq comment-column 48) ))
(add-hook 'perl-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'perl-mode-hook (lambda () (setq comment-column 48) ))
(add-hook 'php-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'php-mode-hook (lambda () (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'javascript-mode-hook (lambda () (setq comment-column 48) ))
(add-hook 'javascript-mode-hook (lambda () (setq comment-column 48) ))
(setq-default left-margin 0)
(add-hook 'idlwave-mode-hook
          (lambda () 
            (local-set-key [(return)] 'newline-and-indent) ))
(add-hook 'f90-mode-hook 
	  (lambda ()
	    (local-set-key [(return)] 'newline-and-indent)))

					; auto-complete
(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1")  
(require 'auto-complete-config)  
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete-1.3.1/dict")  
(ac-config-default)
(put 'scroll-left 'disabled nil)




;;;autoload
(defun linum+-generate-linum-format (format-type limit)
  "Generate line number format by FORMAT-TYPE, LIMIT is `window-end' of win."
  (cond ((stringp format-type) format-type)
        ((or (listp format-type) (vectorp format-type)
             (eq format-type 'dynamic) (eq format-type 'smart))
         (let* ((dynamic-width (or (vectorp format-type) (eq format-type 'smart)))
                (old-format
                 (if (eq format-type 'dynamic)
                     linum+-dynamic-format
                   (if (eq format-type 'smart)
                       linum+-smart-format
                     format-type)))
                (w (length
                    (number-to-string
                     (line-number-at-pos (if dynamic-width limit (point-max))))))
                (new-format
                 (if (listp old-format)
                     (car old-format)
                   (if (vectorp old-format)
                       (aref old-format 0)
                     old-format))))
           (format new-format w)))))



;;lisp-configs-set
(add-to-list 'load-path "/usr/share/emacs/site-lisp/")  

;;show-line-num
(require 'linum)
(global-linum-mode 1)  

;;set compile
(setq compile-command "g++ -Wall -g -pg") 

;;set default height width
(setq default-frame-alist 
      '((height . 25) (width . 100) (menu-bar-lines . 20) (tool-bar-lines . 0))) 
(put 'upcase-region 'disabled nil)


;;global-key bound
(global-set-key [(control return)] 'dabbrev-expand)
(global-set-key [(meta g)] 'goto-line)
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))
(show-paren-mode 't)

;;cedet-config
(require 'cedet) 
(semantic-mode 1) 

(global-ede-mode t)
(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))

(add-hook 'semantic-init-hooks 'my-semantic-hook)
(setq make-backup-files nil)



