HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory share_history incappendhistory
setopt autocd beep extendedglob nomatch notify

[ -f ~/.profile ] && source ~/.profile
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# use emacs style key bindings
bindkey -e

# vim masterrace
export EDITOR=`which vim`

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh

for config (~/.zsh/*.zsh) source $config

