# 1. Shell options & history
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

# 2. Prompt
PROMPT="$ "

# 3. Environment variables
export EDITOR=nvim
export HUSKY=0
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export FAKTORY_LICENSE=6e0a5a3d:eyJuIjoiVGhvbWFzIEZpcnRoIiwiZSI6ImVuZ2luZWVyaW5nQGNvdGVyYS5jbyIsImMiOiJlYmIyNDE5NzphMDM4MDU1OSIsInQiOjIwMH0
export CC=clang
export CXX=clang++

# 4. PATH
export PATH=/opt/homebrew/opt/libpq/bin:\
/opt/homebrew/opt/llvm/bin:\
$HOME/.local/bin:\
$HOME/.local/zig:\
/usr/local/MacGPG2/bin:\
/usr/local/bin:\
/usr/bin:\
/bin:\
/usr/sbin:\
/sbin:\
/usr/local/sbin

# 5. Tool setup

# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# cargo/rust
. "$HOME/.cargo/env"

# fnm (node)
eval "$(fnm env --use-on-cd)"

# bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# gcloud
if [ -f "$HOME/.local/bin/google-cloud-sdk/path.zsh.inc" ]; then
    . "$HOME/.local/bin/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/.local/bin/google-cloud-sdk/completion.zsh.inc" ]; then
    . "$HOME/.local/bin/google-cloud-sdk/completion.zsh.inc"
fi

# kubectl
source <(kubectl completion zsh)

# 6. Completions
fpath+=/opt/homebrew/share/zsh/site-functions
fpath+=~/.zfunc
autoload -Uz compinit; compinit
zstyle ':completion:*' menu select

# 7. Aliases
alias sudo="sudo "
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias sensei-dev='uv run --project $HOME/tdfirth.com/sensei sensei'
