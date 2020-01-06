;;; mytools/youdao/config.el -*- lexical-binding: t; -*-

(use-package! youdao-dictionary
  :config
  (map!
   :leader
   :prefix ("e" . "Evan专属")
   (:prefix ("y" . "有道翻译")
     :desc "翻译当前光标下的单词-tooltip" "t" #'youdao-dictionary-search-at-point-tooltip
     :desc "翻译当前光标下的单词-frame" "f" #'youdao-dictionary-search-at-point-posframe
     :desc "播放当前光标下的单词" "p" #'youdao-dictionary-play-voice-at-point
     :desc "替换当前光标下的单词" "r" #'youdao-dictionary-search-and-replace)))
