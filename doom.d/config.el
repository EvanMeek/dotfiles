;;; config/private/+ui.el -*- lexical-binding: t; -*-

(load! "+bindings")
(load! "+ui")
(load! "+org")

;; remove doom advice, I don't need deal with comments when newline
(advice-remove #'newline-and-indent #'doom*newline-indent-and-continue-comments)


;; Reconfigure packages
(after! evil-escape
  (setq evil-escape-key-sequence "jk"))

  
(after! projectile
  (setq compilation-read-command nil)  ; no prompt in projectile-compile-project
  (projectile-register-project-type 'cmake '("CMakeLists.txt")
                                    :configure "cmake %s"
                                    :compile "cmake --build Debug"
                                    :test "ctest")

  (setq projectile-require-project-root t)
  (setq projectile-project-root-files-top-down-recurring
        (append '("compile_commands.json")
                projectile-project-root-files-top-down-recurring)))

(after! company
  (setq company-minimum-prefix-length 1
        company-idle-delay 0
        company-tooltip-limit 10
        company-show-numbers t
        company-global-modes '(not comint-mode erc-mode message-mode help-mode gud-mode)
        ))


(after! yasnippet
  (add-to-list 'yas-snippet-dirs #'+my-private-snippets-dir nil #'eq))



;; (after! format
;;   (set-formatter!
;;     'clang-format
;;     '("clang-format"
;;       ("-assume-filename=%S" (or (buffer-file-name) ""))
;;       "-style=Google"))
;;   :modes
;;   '((c-mode ".c")
;;     (c++-mode ".cpp")
;;     (java-mode ".java")
;;     (objc-mode ".m")
;;     ))

;; (after! ws-butler
;;   (setq ws-butler-global-exempt-modes
;;         (append ws-butler-global-exempt-modes
;;                 '(prog-mode org-mode))))


;; (after! tex
;;   (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil t))
;;   (setq-hook! LaTeX-mode TeX-command-default "XeLaTex")

;;   (setq TeX-save-query nil)

;;   (when (fboundp 'eaf-open)
;;     (add-to-list 'TeX-view-program-list '("eaf" TeX-eaf-sync-view))
;;     (add-to-list 'TeX-view-program-selection '(output-pdf "eaf"))))



;; (after! eshell
;;   (setq eshell-directory-name (expand-file-name "eshell" doom-etc-dir)))

(global-auto-revert-mode 0)

(after! lsp
  (setq lsp-auto-guess-root t))

(after! lsp-ui
  (add-hook! 'lsp-ui-mode-hook #'lsp-ui-doc-mode)
  (setq
   lsp-ui-doc-use-webkit nil
   lsp-ui-doc-max-height 20
   lsp-ui-doc-max-width 50
   lsp-ui-sideline-enable nil
   lsp-ui-peek-always-show t)
  (map!
   :map lsp-ui-peek-mode-map
   "h" #'lsp-ui-peek--select-prev-file
   "j" #'lsp-ui-peek--select-next
   "k" #'lsp-ui-peek--select-prev
   "l" #'lsp-ui-peek--select-next-file))

(after! ccls
  (setq ccls-initialization-options `(:cache (:directory ,(expand-file-name "~/Code/ccls_cache"))
                                             :compilationDatabaseDirectory "build"))

  (setq ccls-sem-highlight-method 'font-lock)
  (ccls-use-default-rainbow-sem-highlight)
  (evil-set-initial-state 'ccls-tree-mode 'emacs))


(use-package! visual-regexp
  :commands (vr/query-replace vr/replace))

(use-package! package-lint
  :commands (package-lint-current-buffer))

(use-package! auto-save
  :load-path +my-ext-dir
  :config
  (setq +my-auto-save-timer nil)
  (setq auto-save-slient t))

(use-package! openwith
  :load-path +my-ext-dir
  :config
  (setq openwith-associations
        '(
          ("\\.docx?\\'" "wps" (file))
          ("\\.pptx?\\'" "wpp" (file))
          ("\\.xlsx?\\'" "et" (file))))
  (add-hook! 'emacs-startup-hook :append #'openwith-mode))

(use-package eaf
  :load-path "~/.emacs.d/site-lisp/emacs-application-framework" ; Set to "/usr/share/emacs/site-lisp/eaf" if installed from AUR
  :custom
  (eaf-find-alternate-file-in-dired t)
  :config
  ;; (setq eaf-proxy-type "socks5")
  ;; (setq eaf-proxy-host "127.0.0.1")
  ;; (setq eaf-proxy-port "1080")
  (eaf-setq eaf-browser-dark-mode "true")
  (eaf-setq eaf-mindmap-dark-mode "true")
  (eaf-setq eaf-pdf-dark-mode "true")
  (eaf-setq eaf-browser-default-zoom "1.5")
  (eaf-bind-key scroll_up "RET" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down_page "DEL" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
  (eaf-bind-key take_photo "p" eaf-camera-keybinding))


(use-package company-english-helper
  :load-path "~/.emacs.d/site-lisp/company-english-helper")

(defun toggle-company-english-helper-e ()
  "Toggle company english helper."
  (interactive)
  (if company-english-helper-active-p
      (progn
        (setq company-backends (remove 'company-english-helper-search company-backends))
        ;; I need remove `company-english-helper-search' with `company-yasnippet',
        ;; it's not enough just remove `company-english-helper-search' from `company-backends'
        (setq company-backends (remove '(company-english-helper-search :with company-yasnippet) company-backends))
        (setq company-english-helper-active-p nil)
        (message "English helper has disable."))
    (if (not company-mode)
        (company-mode t))
    (add-to-list 'company-backends 'company-english-helper-search)
    (setq company-english-helper-active-p t)
    (message "English helper has enable.")))


;; (after! geiser
;;   (setq-default geiser-default-implementation 'chez))

;; (use-package! keyfreq)

;; (use-package! evil-matchit)

;; (use-package! nsis-mode
;;   :mode ("\.[Nn][Ss][HhIi]\'". nsis-mode))


;; server
;; (setq server-auth-dir (expand-file-name doom-etc-dir))
;; (setq server-name "emacs-server-file")
;; (server-start)

;; C Source Directory
(setq find-function-C-source-directory "/home/evanmeek/.emacs.d/source/emacs-26.3")

;; 修改Emacs GC时间
(defvar k-gc-timer
  (run-with-idle-timer 15 t
                       'garbage-collect))
;; 动态修改下次GC的时间
(defmacro k-time (&rest body)
  "Measure and return the time it takes evaluating BODY."
  `(let ((time (current-time)))
     ,@body
     (float-time (time-since time))))

(defvar k-gc-timer
  (run-with-idle-timer 15 t
                       (lambda ()
                         (message "Garbage Collector has run for %.06fsec"
                                  (k-time (garbage-collect))))))
