# .bash_profile
#nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"

# Load profile
if [ -f ~/.profile ]; then
	. ~/.profile
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Load anything that is not checked in to GH.
if [ -f ~/.profilesecrets ]; then
	. ~/.profilesecrets
fi
. "$HOME/.cargo/env"
