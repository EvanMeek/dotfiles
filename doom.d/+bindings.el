;;; config/private/+bindings.el -*- lexical-binding: t; -*-
(map! [remap indent-region] #'+my/indent-or-format
      :i "C-f" #'forward-char
      :i "C-b" #'backward-char
      :i "C-n" #'next-line
      :i "C-p" #'previous-line
      (:leader
        (:desc "toggle" :prefix "t"
          :desc "Transparency"     :n  "T"    #'+my/toggle-transparency
          :desc "Auto save"        :n  "a"    #'+my/toggle-auto-save
          :desc "Comment "         :n  "c"    #'comment-line
          :desc "Cycle theme"      :n  "t"    #'+my/toggle-cycle-theme
          :desc "English Helper"   :n  "e"    #'toggle-company-english-helper-e
          :desc "随机切换主题"     :n  "r"    #'+my/random-toggle-theme
          )
        (:prefix "r"
          :desc "replace"          :n  "r"    #'vr/replace
          :desc "query replace"    :n  "R"    #'vr/query-replace)
        (:prefix "e"
          :desc "Open with Chrome" :n "c" #'browse-this-chrome)
        ))
