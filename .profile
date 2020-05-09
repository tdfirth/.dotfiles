# .profile
alias sudo="sudo "
alias vim="nvim"
alias vimdiff="nvim -d"
alias xclip="xclip -selection c"

# .dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export PATH=$HOME/go/bin:$HOME/.opam/default/bin:$HOME/.cargo/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/usr/share/Modules/bin

# User specific environment and startup programs
export EDITOR=nvim

# rs

# go

# py
export VIRTUALENV_WRAPPER=/usr/bin/python3
export WORKON_PROJECT_HOME=$HOME/.virtualenvs
source $HOME/.local/bin/virtualenvwrapper.sh

# ocaml
test -r $HOME/.opam/opam-init/init.sh && . $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
eval $(opam env)

# util
alias inflate='ruby -r zlib -e "STDOUT.write Zlib::Inflate.inflate(STDIN.read)"'
