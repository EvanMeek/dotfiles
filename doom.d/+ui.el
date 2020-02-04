;;; config/private/+ui.el -*- lexical-binding: t; -*-

;; theme
;; cycle by +my/toggle-cycle-theme, binding SPC t t
(defvar +my-themes '(doom-one doom-one-light doom-dracula))
(setq doom-theme 'doom-dracula)

;; disable line-number
(setq display-line-numbers-type nil)



;; font

(setq doom-font (font-spec :family "JetBrains Mono" :size 20 :style 'Regular))
;;
(set-default-font "-JB  -JetBrains Mono-normal-normal-normal-*-20-*-*-*-m-0-iso10646-1")
;; banner
(setq +doom-dashboard-banner-file (expand-file-name "img/ue-pink.png" doom-private-dir))

(defun +my|init-font(frame)
  (with-selected-frame frame
    (if (display-graphic-p)
        (+my/better-font))))

(if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions #'+my|init-font)
  (+my/better-font))
