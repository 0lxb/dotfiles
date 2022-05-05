#!/bin/sh
cat << EOF >> ~/.profile
alias rm='safe-rm -i --preserve-root'
alias lf='du -d 1 -h'
alias lh='ls -alhtF'
alias rm -rf='rm -rf -i --preserve-root'
alias vfzf='vim $(fzf)'

# https://github.com/sharkdp/fd
export FZF_DEFAULT_COMMAND="fd --exclude={.gidecodass-cache,node_modules} --type f"
## https://github.com/junegunn/fzf
#export FZF_DEFAULT_OPTS="--preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -800'"
EOF
