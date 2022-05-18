#
# ~/.bash_profile
#
export EDITOR=nvim
alias ft="grep -rnw './' -e $1"
eval `ssh-agent -s`
export LS_COLORS='di=34:ln=36:pi=35:so=33:or=41:ex=32:*.tar=31:*.mkv=31:*.mp4=31:*.key=33:*.key.pub=35:*.zip=31:*.7z=31:*.jar=35:*.class=35:*.iso=96:*.pdf=32:*.deb=33:*.jpg=35:*.png=35:*.odt=32:*.rzdb=35:*.xlsx=32:*.xcf=32:*.html=32:*.apk=31:*.jadx=35:*.tox=36:*.ods=32:*.uxf=32'

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"
