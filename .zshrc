# prompt
fpath+=$HOME/.zsh/pure
autoload -Uz compinit && compinit
autoload -U promptinit; promptinit
prompt pure

# completions

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
source $HOME/.local/bin/virtualenvwrapper.sh

