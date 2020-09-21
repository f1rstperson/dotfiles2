;; ----------------------------------------------------------------------
;; telephone line
;; ----------------------------------------------------------------------

(use-package telephone-line :ensure t :demand t :config

  (telephone-line-defsegment fp/telephone-line-airline-position-segment ()
    "Position segment imitating vim-airline's
appearance. Optional args set padding on lines/columns."
    (let* ((l (number-to-string 4))
           (c (number-to-string 3)))
      (if (eq major-mode 'pdf-view-mode)
          (telephone-line-raw mode-line-position t)
        `((-3 "%p")
          ,(concat " %" l "l" ":%" c
                   (if (bound-and-true-p
                        column-number-indicator-zero-based) "c" "C"))))))

  ;;   (telephone-line-defsegment fp/telephone-line-vcs-segment ()
  ;;     "Show current VCS branch and status indicator. Taken from
  ;; Protesilaos Stavrou's config."
  ;;     (when (and vc-mode buffer-file-name)
  ;;       (let* ((backend (vc-backend buffer-file-name))
  ;;              (state (vc-state buffer-file-name backend)))
  ;;         (concat
  ;;          (telephone-line-raw
  ;;           (format "%s" (substring vc-mode (+ (if (eq backend 'Hg) 2 3) 2))))
  ;;          (cond ((memq state '(edited added))
  ;;                 (telephone-line-raw " *"))
  ;;                ((eq state 'needs-merge)
  ;;                 (telephone-line-raw " ?"))
  ;;                ((eq state 'needs-update)
  ;;                 (telephone-line-raw " !"))
  ;;                ((memq state '(removed conflict unregistered))
  ;;                 (telephone-line-raw " ×"))
  ;;                (t
  ;;                 (telephone-line-raw "")))))))


  (telephone-line-defsegment fp/telephone-line-eyebrowse-segment ()
    "Show the current eyebrowse window config if eyebrowse is
available."
    (if (featurep 'eyebrowse)
        (concat "[" (number-to-string
                     (eyebrowse--get 'current-slot))
                "] ") ""))

  (telephone-line-defsegment fp/telephone-line-dired-rsync-segment ()
    "Show the current status of dired-rsync if available."
    (propertize (or (and (featurep 'dired-rsync) dired-rsync-modeline-status) "")
                'face 'warning))

  ;; --- make evil tag more minimal ---
  (set-face-attribute
   'telephone-line-evil-normal nil
   :foreground nil :background nil :inherit 'mode-line)
  (set-face-attribute
   'telephone-line-evil-insert nil
   :foreground nil :background nil :inherit 'mode-line)
  (setq telephone-line-evil-use-short-tag t)

  ;; --- Position of segments ---
  (setq telephone-line-lhs
        '((nil telephone-line-evil-tag-segment)
          (accent telephone-line-process-segment)
          (nil telephone-line-buffer-segment)
          (nil fp/telephone-line-airline-position-segment))
        telephone-line-rhs
        '((nil telephone-line-flycheck-segment)
          (nil fp/telephone-line-eyebrowse-segment)
          (nil telephone-line-misc-info-segment
               fp/telephone-line-dired-rsync-segment)))

  ;; --- Disable sperators ---
  (setq telephone-line-primary-left-separator telephone-line-nil
        telephone-line-primary-right-separator telephone-line-nil
        telephone-line-secondary-left-separator telephone-line-nil
        telephone-line-secondary-right-separator telephone-line-nil))

(telephone-line-mode 1)

;; ----------------------------------------------------------------------
;; custom faces
;; ----------------------------------------------------------------------

(custom-set-faces
 '(mode-line-buffer-id ((t (:inherit font-lock-variable-name-face)))))

;; ----------------------------------------------------------------------
;; legacy - my own format
;; ----------------------------------------------------------------------

;; (defun simple-mode-line-render (left right)
;;   "Return a string of `window-width' length containing LEFT, and RIGHT aligned respectively."
;;   (let* ((available-width (- (window-total-width)
;;                              (+ (length (format-mode-line left))
;;                                 (length (format-mode-line right))))))
;;     (append left (list (format (format "%%%ds" available-width) "")) right)))


;; (setq mode-line-position ""
;;       fp/mode-line-left '((:eval (if (featurep 'eyebrowse)
;;                                      (concat " [" (number-to-string
;;                                                    (eyebrowse--get 'current-slot))
;;                                              "] ") " "))
;;                           ("%e%l:%c %* "
;;                            (:eval (propertize "%b" 'face 'mode-line-buffer-id))
;;                            mode-line-position
;;                            evil-mode-line-tag))
;;       fp/mode-line-right '((:eval global-mode-string " "))
;;       fp/mode-line-format '((:eval (simple-mode-line-render
;;                                     fp/mode-line-left fp/mode-line-right))))

;; (setq-default mode-line-format fp/mode-line-format)
;; (set-local-variable-in-all-buffers mode-line-format fp/mode-line-format)

;; (defun fp/toggle-modeline ()
;;   (interactive)
;;   (if (eq mode-line-format nil)
;;       (progn
;;         (setq-default mode-line-format fp/mode-line-format)
;;         (set-local-variable-in-all-buffers mode-line-format fp/mode-line-format))
;;     (progn
;;       (setq-default mode-line-format nil)
;;       (set-local-variable-in-all-buffers mode-line-format nil))))

;; (setq display-time-load-average-threshold 0.8
;;       display-time-format " %H:%M")
;; (display-time-mode 1)


(provide 'config-modeline)
