(when (eq system-type 'windows-nt)

  ;; open with default application
  (defun w32-browser (doc) (w32-shell-execute 1 doc))
  ;; fix slow icon display
  (setq inhibit-compacting-font-caches t)
  (setq proced-custom-attributes nil)
  (setq w32-pipe-read-delay 0)

  (setq find-program "c:/tools/cygwin/bin/find.exe")
  (add-to-list 'exec-path (file-name-directory (expand-file-name (car command-line-args))))

  (with-eval-after-load "config-eshell" (setq eshell-aliases-file "~/sync/emacs/random/eshell-aliases-windows"))

  (use-package powershell :ensure t :defer t))



(defun fp/remove-dos-eol ()
  "Do not show  (^M) in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

;; --------------------------------------------------------------------------------
;; Notes
;; --------------------------------------------------------------------------------
;; shortcut to emacsclientw.exe
;; (target  . X:\path\to\emacs\emacsclientw.exe -na "X:\path\to\emacs\emacsclientw.exe" -c -n)
;; (open in . "%HOME%")
;; (name    . emacs)


(provide 'config-windows)
