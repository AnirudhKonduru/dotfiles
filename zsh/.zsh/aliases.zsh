# for WSL
export WIN_HOME="/mnt/c/Users/aniru"
export ONEDRIVE="/mnt/c/Users/aniru/OneDrive"

# locale settings
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

alias less='less -rN '
alias wget='wget -c '

case "$OSTYPE" in
  linux*)
    alias ls="ls --color=auto -hF "
  ;;
  dragonfly*|freebsd*|netbsd*|openbsd*|darwin*)
    alias ls="ls -hGF "
  ;;
esac

alias la='ls -a '
alias ll='ls -l '
alias lt='ls -t '

