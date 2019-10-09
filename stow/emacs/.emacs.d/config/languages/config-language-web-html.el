(require-and-log 'config-language-web-general)

(use-package ng2-mode :ensure t
  :config
  (evil-define-key 'insert ng2-html-map (kbd "M-<") 'sgml-close-tag))

(add-hook 'sgml-mode-hook 'sgml-electric-tag-pair-mode)
(setq sgml-basic-offset 4)

(add-hook 'sgml-mode-hook 'highlight-indent-guides-mode)

(use-package emmet-mode
  :ensure t
  :init
  (add-hook 'sgml-mode-hook 'emmet-mode)
  :config
  (evil-define-key 'insert emmet-mode-keymap (kbd "C-,") 'emmet-expand-yas))

(provide 'config-language-web-html)
