clear
plugins=(asdf)

PROMPT="$ "

alias sudo="sudo "
alias vim="nvim"
alias light="kitten themes --reload-in=all zenwritten_light"
alias dark="kitten themes --reload-in=all zenwritten_dark"
set -o emacs

# .dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# User specific environment and startup programs
export EDITOR=nvim

export PATH=/opt/homebrew/opt/libpq/bin:$HOME/go/bin:/usr/local/go/bin:$HOME/.cargo/bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:/usr/local/MacGPG2/bin:

# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# completions
fpath+=/opt/homebrew/share/zsh/site-functions

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# asdf
. "$HOME/.asdf/asdf.sh"

# JS -----------------------------------------------
# bun
[ -s "/Users/tdfirth/.bun/_bun" ] && source "/Users/tdfirth/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export HUSKY=0
export PNPM_HOME="/Users/tdfirth/Library/pnpm"
PATH="$PNPM_HOME:$PATH"
# pnpm end

# Kubectl autocompletion
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
source <(kubectl completion zsh)

# GCLOUD -----------------------------------------------
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tdfirth/.local/bin/google-cloud-sdk/path.zsh.inc' ]; then 
    . '/Users/tdfirth/.local/bin/google-cloud-sdk/path.zsh.inc'; 
fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/tdfirth/.local/bin/google-cloud-sdk/completion.zsh.inc' ]; then 
    . '/Users/tdfirth/.local/bin/google-cloud-sdk/completion.zsh.inc'; 
fi

# Zig
export PATH="$HOME/.local/zig:$PATH"

# clojure
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
alias sdkman="unalias sdkman; source "$HOME/.sdkman/bin/sdkman-init.sh"; sdkman $@"