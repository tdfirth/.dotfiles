# .bashrc
xset r rate 250 50
PS1="$ "
export EDITOR=nvim

HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# Immediately append to history file:
setopt INC_APPEND_HISTORY

# Record timestamp in history:
setopt EXTENDED_HISTORY

# Expire duplicate entries first when trimming history:
setopt HIST_EXPIRE_DUPS_FIRST

# Dont record an entry that was just recorded again:
setopt HIST_IGNORE_DUPS

# Delete old recorded entry if new entry is a duplicate:
setopt HIST_IGNORE_ALL_DUPS

# Do not display a line previously found:
setopt HIST_FIND_NO_DUPS

# Dont record an entry starting with a space:
setopt HIST_IGNORE_SPACE

# Dont write duplicate entries in the history file:
setopt HIST_SAVE_NO_DUPS

# Share history between all sessions:
setopt SHARE_HISTORY

# Execute commands using history (e.g.: using !$) immediatel:
unsetopt HIST_VERIFY

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
if [ -f '/home/tom/.local/google-cloud-sdk/path.bash.inc' ]; then . '/home/tom/.local/google-cloud-sdk/path.bash.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/home/tom/.local/google-cloud-sdk/completion.bash.inc' ]; then . '/home/tom/.local/google-cloud-sdk/completion.bash.inc'; fi

# kubectl
source /usr/share/bash-completion/bash_completion
source <(kubectl completion bash)

# >>> conda initialize >>>
if [ -f "/home/tom/miniconda3/etc/profile.d/conda.sh" ]; then
    . "/home/tom/miniconda3/etc/profile.d/conda.sh"
else
    export PATH="/home/tom/miniconda3/bin:$PATH"
fi
# <<< conda initialize <<<


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# pnpm
export PNPM_HOME="/home/tom/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
