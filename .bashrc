# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'


#alias for zed
alias zed='zeditor'

# Go path
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:/usr/local/go/bin:$GOBIN"

#ghostty specs
alias neofetch='~/bin/ghosttyfetch'
#alias fastfetch='~/bin/ghosttyfetch'
alias info='~/bin/ghosttyfetch'


