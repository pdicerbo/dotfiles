#
# ~/.bash_profile
#
export PATH=$PATH:$HOME/.scripts

[[ -f ~/.bashrc ]] && . ~/.bashrc

# decomment following lines to enable auto startx
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec startx # >& MyXLog
fi
