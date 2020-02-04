alias vim='emacs';
alias v='emacs';
alias e='emacs';
alias bci='brew cask install';
alias bi='brew install';
alias bs='brew search';
alias bu='brew uninstall';
alias ga.='git add .';
alias gaa='git add -A';
alias gm='git commit -m';
alias gm8='git commit -m "update"';
alias gp='git push'
alias gp8='git push origin dev'
alias gs='git status'
alias hgd='hexo g -d'
alias hgs='hexo g && hexo s'
alias hn='hexo new'
alias pc='proxychains'
alias p='sudo pacman -S'
alias pss='pacman -Ss'
alias pc='proxychains'
alias n='neofetch'
alias r='ranger'
alias y='yay'
alias ys='yay -Ss'
alias m='tldr'
alias ax='aria2c -x16'
alias pf='curl -F "c=@-" "https://fars.ee/?u=1"'
# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"
# 关闭欢迎语
function fish_greeting
end
# Load Oh My Fish configuration.
source $OMF_PATH/init.fish
