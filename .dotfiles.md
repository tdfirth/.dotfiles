# Dotfiles

## Clone
1. `git clone --bare https://github.com/tdfirth/.dotfiles.git $HOME/.dotfiles`
2. `alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
3. `dotfiles checkout`

## Initial setup
1. `git init --bare $HOME/.dotfiles`
2. `alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
3. `dotfiles config --local status.showUntrackedFiles no`
4. `dotfiles add .bashrc && dotfiles commit -m "Added bashrc"`
5. etc
