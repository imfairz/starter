set -gx TERM xterm-256color
set -gx EDITOR nvim
set -gx VISUAL nvim

alias bcn="bat --paging=never"
alias v="nvim"
alias q="exit"
alias cg="cargo"

alias sr="sudo systemctl restart"
alias ss="sudo systemctl status"
alias se="sudo systemctl enable"
alias s0="sudo systemctl stop"

zoxide init fish | source
