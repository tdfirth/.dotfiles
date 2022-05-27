# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Load profile
if [ -f ~/.profile ]; then
        . ~/.profile
fi

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

export ZK_HOME="/home/tom/dropbox/zk"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/tom/.sdkman"
[[ -s "/home/tom/.sdkman/bin/sdkman-init.sh" ]] && source "/home/tom/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export RUSTY_V8_MIRROR=$HOME/.cache/rusty_v8

export PNPM_HOME="/home/tom/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
