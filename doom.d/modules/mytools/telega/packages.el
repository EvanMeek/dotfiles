;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/moudles/mytools/telega/packages.el

(package! telega :recipe
  (:host github
         :repo "zevlg/telega.el"
         :branch "master"
         :files (:defaults "README.md" "etc" "server" "Makefile" "test.el")))
