# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch notify
# End of lines configured by zsh-newuser-install

[ -f ~/.profile ] && source ~/.profile
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.bash_profile ] && source ~/.bash_profile

unsetopt inc_append_history
unsetopt share_history

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

for config (~/.zsh/*.zsh) source $config

