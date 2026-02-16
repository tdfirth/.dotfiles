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

clear
plugins=(asdf)

PROMPT="$ "

alias sudo="sudo "

# .dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# User specific environment and startup programs
export EDITOR=nvim

export PATH=/opt/homebrew/opt/libpq/bin:\
$HOME/go/bin:\
/usr/local/go/bin:\
$HOME/.cargo/bin:\
$HOME/.local/bin:\
/usr/local/MacGPG2/bin:\
/usr/local/bin:\
/usr/bin:\
/bin:\
/usr/sbin:\
/sbin:\
/usr/local/sbin

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
export PNPM_HOME="/Users/tdfirth/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
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

# mojo
export MODULAR_HOME="$HOME/.modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"


. "$HOME/.cargo/env"

export HUSKY=0


fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select

# C++
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export CC=clang
export CXX=clang++

# Sensei
alias sensei-dev='uv run --project /Users/tdfirth/tdfirth.com/sensei sensei'

# Faktory
export FAKTORY_LICENSE=6e0a5a3d:eyJuIjoiVGhvbWFzIEZpcnRoIiwiZSI6ImVuZ2luZWVyaW5nQGNvdGVyYS5jbyIsImMiOiJlYmIyNDE5NzphMDM4MDU1OSIsInQiOjIwMH0
