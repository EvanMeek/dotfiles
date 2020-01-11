alias vim='nvim';
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
# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

set -Ux http_proxy http://127.0.0.1:12333
# Load Oh My Fish configuration.
source $OMF_PATH/init.fish
