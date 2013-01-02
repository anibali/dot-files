# .zshrc
# ------
# Requirements:
# * most (http://www.jedsoft.org/most)
# * command-not-found
# * oh-my-zsh (https://github.com/dismaldenizen/dot-files/tree/master/home/.oh-my-zsh)

# Path to your oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="aiden"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Prevent oh-my-zsh from updating itself
DISABLE_AUTO_UPDATE="true"

plugins=(git ruby)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
PATH="$PATH:/var/lib/gems/1.8/bin:/usr/local/cuda/bin:/opt/cxoffice/bin"

# Enable package suggestions when a command is not found
source /etc/zsh_command_not_found

# Set the default pager to "most"
PAGER="/usr/bin/most -s"
MANPAGER="/usr/bin/most -s"

# Add some colour to certain commands
alias dir='dir --color'
alias spec='spec --color'

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

