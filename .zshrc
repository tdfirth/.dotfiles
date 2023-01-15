# prompt
fpath+=$HOME/.zsh/pure
autoload -Uz compinit && compinit
autoload -U promptinit; promptinit
#prompt pure

PROMPT="$ "

# completions
fpath+=/opt/homebrew/share/zsh/site-functions

# terminal
set -o emacs

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# py
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export VIRTUALENVWRAPPER_PYTHON=~/.pyenv/shims/python
export WORKON_PROJECT_HOME=$HOME/.virtualenvs
# source $HOME/.local/bin/virtualenvwrapper.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.yarn/bin:$PATH"

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/tdfirth/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/tdfirth/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/tdfirth/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/tdfirth/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tdfirth/.local/bin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/tdfirth/.local/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/tdfirth/.local/bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/tdfirth/.local/bin/google-cloud-sdk/completion.zsh.inc'; fi

# Kubectl autocompletion
source <(kubectl completion zsh)
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# opam configuration
[[ ! -r /Users/tdfirth/.opam/opam-init/init.zsh ]] || source /Users/tdfirth/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Zig
export PATH="$HOME/.local/zig:$PATH"

# bun completions
[ -s "/Users/tdfirth/.bun/_bun" ] && source "/Users/tdfirth/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
