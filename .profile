# xset
xset r rate 250 50

# .profile
alias sudo="sudo "
alias vim="nvim"
alias vimdiff="nvim -d"
alias xclip="xclip -selection c"

# .dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export PATH=$HOME/go/bin:/usr/local/go/bin:$HOME/.cargo/bin:$HOME/.local/bin:/opt/gradle-6.4.1/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/usr/share/Modules/bin:$HOME/.cache/rebar3/bin

# User specific environment and startup programs
export EDITOR=nvim

# py
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

