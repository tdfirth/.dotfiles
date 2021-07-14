# Load profile
if [ -f ~/.profile ]; then
	. ~/.profile
fi
eval "$(pyenv init --path)"
