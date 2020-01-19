;;; mytools/google-transalte/config.el -*- lexical-binding: t; -*-

(use-package! google-translate
  :config
  (setq google-translate-default-source-language "en")
  (setq google-translate-default-target-language "zh-CN")
  (setq google-translate-base-url "http://translate.google.cn/translate_a/t"
        google-translate-listen-url "http://translate.google.cn/translate_tts"
        google-translate--tkk-url "http://translate.google.cn/")
  (map!
   :leader
   :prefix ("e" . "Evan专属")
   (:prefix ("g" . "Google翻译")
     :desc "翻译整个Buffer" "b" #'google-translate-buffer)))
