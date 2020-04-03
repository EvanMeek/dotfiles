;;; confe by +my/toggle-cycle-theme, binding SPC t t
(defvar +my-themes '(doom-dark+ doom-solarized-dark doom-nord doom-opera doom-challenger-deep doom-snazzy))
(setq doom-theme 'doom-one)
;; disable line-number
;; (setq display-line-numbers-type nil)

;; (+my/toggle-transparency)
(+my/toggle-transparency)

;; font



(setq doom-font (font-spec :family "Sarasa Mono SC" :size 20 ))
; (set-default-font "-????-等距更纱黑体 SC-normal-normal-normal-*-20-*-*-*-*-0-iso10646-1")
;; banner
(setq +doom-dashboard-banner-file (expand-file-name "banner/ue-colorful.png" doom-private-dir))

;; (defun +my|init-font(frame)
;;   (with-selected-frame frame
;;     (if (display-graphic-p)
;;         (+my/better-font))))

;; (if (and (fboundp 'daemonp) (daemonp))
;;     (add-hook 'after-make-frame-functions #'+my|init-font)
;;   (+my/better-font))
