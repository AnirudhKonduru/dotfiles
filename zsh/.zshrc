# Automatically set window title
set-window-option -g automatic-rename on
set-option -g set-titles on

#set -g default-terminal screen-256color
set -g status-keys vi
set -g history-limit 10000

setw -g mode-keys vi
#set -g mouse on
setw -g monitor-activity on

# THEME
set -g status-bg black
set -g status-fg white

set -g mode-style bg=white,fg=black,bold
# set -g window-status-current-bg white
# set -g window-status-current-fg black
# set -g window-status-current-attr bold
set -g status-interval 60
set -g status-left-length 30
set -g status-left '#[fg=green](#S) #(whoami)'
set -g status-right '#[fg=yellow]#(cut -d " " -f 1-3 /proc/loadavg)#[default] #[fg=white]%H:%M#[default]'


# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch notify
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ani/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

[ -f ~/.profile ] source ~/.profile
[ -f ~/.bash_aliases ] source ~/.bash_aliases
[ -f ~/.bash_profile ] source ~/.bash_profile

unsetopt inc_append_history
unsetopt share_history

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

