## zsh features ##
export HISTFILE=~/.local/.zshhist
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY
setopt PROMPTSUBST
setopt AUTOCD

autoload -Uz compinit; compinit
autoload -Uz promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion::complete:*' gain-priveleges 1
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr "*"
zstyle ':vcs_info:*' stagedstr "+"
zstyle ':vcs_info:git:*' formats " %F{yellow}<%b>%f"

precmd() {
  vcs_info
}

bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

.{1..9} (){ local d=.; repeat "${0:1}" d+=/..; cd "$d";}

## prompt ##
PROMPT='%m \
%F{cyan}%B::%b%f \
%F{green}%3~%f${vcs_info_msg_0_} \
%F{cyan}%B»%b%}%f '
RPROMPT='%(?..%F{red}[%?]%f)'

## env ##
export EDITOR=nvim
export VISUAL=nvim
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

## alias ##
alias ssh='TERM=xterm-256color ssh'
alias sway='~/bin/sway-launch.sh'
alias zth='zathura --fork &> /dev/null'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias dots='git --git-dir=$HOME/.local/cfg --work-tree=$HOME'

## exec ##
gpg-connect-agent updatestartuptty /bye &> /dev/null
