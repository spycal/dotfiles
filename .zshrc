# Created by newuser for 5.9
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

TERM='xterm-256color'
EDITOR='nvim'

alias pf='pfetch'
alias ls='exa --long'
alias xq='xbps-query -Rs'
alias pipes.sh='pipes.sh -t 2'

export PATH="$PATH:$HOME/.cargo/bin:$HOME:$HOME/.local/bin"
