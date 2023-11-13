# .bashrc
xset r rate 250 50
PS1="$ "
export EDITOR=nvim

background() {
    echo $(cat ~/.config/kitty/current-theme.conf | grep -E -m1 '(light|dark)' | sed 's/## name: zenwritten_//')
}

nvim_with_explicit_background() {
    nvim --cmd "set background=$(background)" "$@"
}

# .profile
alias sudo="sudo "
alias nvim="nvim_with_explicit_background"
alias vim="nvim"
alias vimdiff="nvim -d"
alias light="kitten themes --reload-in=all zenwritten_light"
alias dark="kitten themes --reload-in=all zenwritten_dark"
alias xclip="xclip -selection c"

# .dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

#export PATH=$HOME/.local/kitty.app/bin:\
export PATH=$HOME/go/bin:\
/usr/local/go/bin:\
$HOME/.cargo/bin:\
$HOME/.local/bin:\
/usr/local/bin:\
/usr/local/sbin:\
/usr/bin:\
/usr/sbin:\
/usr/share/Modules/bin

# User specific environment and startup programs

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
export HUSKY=0

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/tom/.sdkman"
[[ -s "/home/tom/.sdkman/bin/sdkman-init.sh" ]] && source "/home/tom/.sdkman/bin/sdkman-init.sh"

export PNPM_HOME="/home/tom/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
alias pnx="pnpm exec nx "

# gcloud
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/tom/downloads/google-cloud-sdk/path.bash.inc' ]; then . '/home/tom/downloads/google-cloud-sdk/path.bash.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/home/tom/downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/home/tom/downloads/google-cloud-sdk/completion.bash.inc'; fi
