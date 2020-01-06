;;; mytools/music/config.el -*- lexical-binding: t; -*-

(use-package! bongo
  :config
  (map!
   :leader
   :prefix ("e" ."Evan专属")
   (:prefix ("b" . "Bongo")
     :desc "播放Point处的曲子" "RET"  #'bongo-dwim
     :desc "移除选中的曲子" "x"  #'bongo-kill-region
     :desc "移除光标处曲子" "d"  #'bongo-kill-line
     :desc "撤回操作" "_"  #'bongo-undo
     :desc "继续/暂停" "SPC"  #'bongo-pause/resume
     :desc "展开专辑" "TAB"  #'bongo-toggle-collapsed
     :desc "回退10%" "h" #'bongo-seek-backward-10
     :desc "前进10%" "l" #'bongo-seek-forward-10
     :desc "添加至播放列表" "a"  #'bongo-insert-enqueue
     :desc "下一首" "n"  #'bongo-play-next
     :desc "上一首" "p" #'bongo-play-previous
     :desc "随机播放" "r" #'bongo-play-random
     :desc "随机添加音乐至播放列表" "s" #'bongo-sprinkle
     :desc "打开播放列表目录" "o d" #'bongo-dired-line
     :desc "打开播放列表" "o b" #'bongo-playlist
     :desc "打开播放曲库" "o m" #'bongo-library
     :desc "查看Bongo Buffer" "o l" #'bongo-list-buffers)))
