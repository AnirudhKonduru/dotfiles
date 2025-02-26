HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory share_history incappendhistory
setopt autocd beep extendedglob nomatch notify

# turn off the beep
unsetopt beep

[ -f ~/.profile ] && source ~/.profile
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# use emacs style key bindings
bindkey -e

# vim masterrace
export EDITOR=`which vim`

SSH_AGENT_PID=""
SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"

# Depending on how you installed fzf, it's shell files could be in any of these places
# if installed with git
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# if installed with apt (debian)
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
# if installed with pacman (arch)
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh


for config (~/.zsh/*.zsh) source $config

source /usr/share/nvm/init-nvm.sh

# opam configuration
[[ ! -r /home/kondu/.opam/opam-init/init.zsh ]] || source /home/kondu/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
# >> k3s command completion (start)
. <(k3s completion zsh)
# >> k3s command completion (end)
