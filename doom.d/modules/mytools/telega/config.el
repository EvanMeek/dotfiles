;;; ~/telega-config.el -*- lexical-binding: t; -*-


;; copied from https://github.com/sarg/dotfiles/
(use-package! telega
  :commands (telega)
  :hook (telega-chat-mode . doom-mark-buffer-as-real-h)
  :config
  (telega-mode-line-mode 1)
  (set-popup-rule! (regexp-quote telega-root-buffer-name)
    :side 'left :size 30 :quit nil :modeline t :select t)
  (set-popup-rule! "^◀[[({<].*[\])>}]$"
    :side 'right :size 60 :quit nil :modeline t :select t)
  (setq telega-use-tracking t
        telega-notifications-mode t
        telega-chat-footer-show-pinned-message nil
        telega-known-inline-bots '("@shufmbot")
        telega-sticker-set-download t
        telega-chat-button-width 28
        telega-proxies (list '(:server "127.0.0.1" :port 1081 :enable t
                                       :type (:@type "proxyTypeSocks5")))
        telega-root-fill-column 48)
  (when (featurep! :completion ivy)
    (load! "+ivy")
    (map! ;:map (telega-root-mode-map telega-chat-mode-map)
     :leader
     :prefix ("e" . "Evan专属")
     (:prefix ("t" . "telega")
       :desc "ivy-搜索telega聊天" "c" #'ivy-telega-chat-with)))
  (when (featurep! :completion company)
    (add-hook 'telega-chat-mode-hook
              (lambda ()
                (set (make-local-variable 'company-backends)
                     (append '(telega-company-emoji
                               telega-company-username
                               telega-company-hashtag)
                             (when (telega-chat-bot-p telega-chatbuf--chat)
                               '(telega-company-botcmd)))))))
  (when (featurep! :editor evil)
    (map!
     (:map telega-msg-button-map
       "k" nil
       "l" nil)))
  (after! all-the-icons
    (add-to-list 'all-the-icons-mode-icon-alist
                 '(telega-root-mode all-the-icons-fileicon "telegram"
                                    :heigt 1.0
                                    :v-adjust -0.2
                                    :face all-the-icons-yellow))
    (add-to-list 'all-the-icons-mode-icon-alist
                 '(telega-chat-mode all-the-icons-fileicon "telegram"
                                    :heigt 1.0
                                    :v-adjust -0.2
                                    :face all-the-icons-blue))))
