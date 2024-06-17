(setq fancy-splash-image "~/.config/doom/images/xiao_resized.png")
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)

(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump)
      (:after dired
       (:map dired-mode-map
        :desc "Dired view file"           "d v" #'dired-view-file)))
(setq delete-by-moving-to-trash t
      trash-directory "~/.Trash/")
(dired-preview-global-mode 1)
(setq dired-preview-delay 0.1)

(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file ; use dired-find-file instead of dired-open.
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-do-chmod
  (kbd "O") 'dired-do-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-do-rename
  (kbd "T") 'dired-do-touch
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  (kbd "Z") 'dired-do-compress
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-do-kill-lines
  (kbd "f") 'dired-create-empty-file
  (kbd "% l") 'dired-downcase
  (kbd "% m") 'dired-mark-files-regexp
  (kbd "% u") 'dired-upcase
  (kbd "* %") 'dired-mark-files-regexp
  (kbd "* .") 'dired-mark-extension
  (kbd "* /") 'dired-mark-directories
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)

(setq doom-theme 'doom-rose-pine-dawn)

(setq doom-font (font-spec :family "Cartograph CF" :size 16 :weight 'regular))

(evil-commentary-mode)
(setq display-line-numbers-type 'nil)

(use-package! doom-nano-modeline
  :config
  (doom-nano-modeline-mode 1)
  (global-hide-mode-line-mode 1))

(setq org-directory "~/Documents/org/")
(setq org-agenda-files '("~/Documents/org/agenda/"))

(use-package spacious-padding
  :ensure t
  :init
  (setq spacious-padding-widths
        '( :internal-border-width 15
         :header-line-width 0
         :mode-line-width 0
         :tab-width 4
         :right-divider-width 30
         :scroll-bar-width 1))
  (spacious-padding-mode t))

(global-hl-line-mode -1)
(remove-hook 'doom-first-buffer-hook #'global-hl-line-mode)

(setq scroll-margin 7)

(add-to-list 'default-frame-alist '(undecorated-round . t))

(global-whitespace-mode -1)
