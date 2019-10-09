(require-and-log 'config-programming-general)
(require 'python)

;; ----------------------------------------------------------------------
;; debugging
;; ----------------------------------------------------------------------
(setq realgud:pdb-command-name "python -m pdb")
(evil-leader/set-key-for-mode 'python-mode "mD" 'realgud:pdb)

;; ----------------------------------------------------------------------
;; flycheck
;; ----------------------------------------------------------------------
(config-add-external-dependency 'flake8 'config-python "flycheck backend"
                                (lambda () (executable-find "flake8"))
                                "pip install flake8" "pip install flake8")
(add-hook 'python-mode-hook 'flycheck-mode)

;; ----------------------------------------------------------------------
;; completion
;; ----------------------------------------------------------------------
(use-package company-jedi
  :ensure t
  :config
  (add-to-list 'company-backends 'company-jedi)
  (defun fp/python-jedi-hook ()
    (jedi:setup)
    (company-mode))
  (config-add-external-dependency 'virtualenv 'config-python "virtual envs"
                                  (lambda () (executable-find "virtualenv"))
                                  "pip3 install virtualenv" "pip3 install virtualenv")
  (config-add-external-dependency 'jedi 'config-python "autocomplete"
                                  (lambda () (file-exists-p (car jedi:server-command)))
                                  "M-x jedi:install-server" "M-x jedi:install-server")
  (when (config-external-check-list '(jedi)) (add-hook 'python-mode-hook 'fp/python-jedi-hook)))


;; --------------------------------------------------------------------------------
;; REPL
;; --------------------------------------------------------------------------------
(add-hook 'inferior-python-mode-hook 'company-mode)

(setq python-shell-interpreter "python"
      python-shell-completion-native-enable nil)

(ignore-errors (mkdir "~/.python_venvs/"))
(setenv "WORKON_HOME" (concat (expand-file-name "~") "/.python_venvs/"))
(use-package pyvenv :ensure t)

;; --------------------------------------------------------------------------------
;; appearance
;; --------------------------------------------------------------------------------
(defun config--python-pretty-symbols ()
  (mapc (lambda (pair) (push pair prettify-symbols-alist))
        '(("in" .       #x2208)
          ("not in" .   #x2209)
          ("return" .   #x21d2)))
  (prettify-symbols-mode 1))

(add-hook 'python-mode-hook 'config--python-pretty-symbols)


;; --------------------------------------------------------------------------------
;; bindings
;; --------------------------------------------------------------------------------

(evil-leader/set-key-for-mode 'python-mode
  "eb" 'python-shell-send-buffer
  "ef" 'python-shell-send-defun
  "er" 'python-shell-send-region
  "sd" 'lsp-ui-doc-show
  "sD" 'lsp-ui-doc-hide)

(define-key inferior-python-mode-map (kbd "C-l") 'comint-clear-buffer)


(provide 'config-language-python)
