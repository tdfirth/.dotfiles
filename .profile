# .profile
alias sudo="sudo "
alias vim="nvim"
alias vimdiff="nvim -d"
alias xclip="xclip -selection c"

# .dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export PATH=$HOME/go/bin:/usr/local/go/bin:$HOME/.opam/default/bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.poetry/bin:/opt/gradle-6.4.1/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/MacGPG2/bin:$HOME/.cache/rebar3/bin

# User specific environment and startup programs
export EDITOR=nvim

# py
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
#export WORKON_PROJECT_HOME=$HOME/.virtualenvs
#source $HOME/.local/bin/virtualenvwrapper.sh

# util
alias inflate='ruby -r zlib -e "STDOUT.write Zlib::Inflate.inflate(STDIN.read)"'
