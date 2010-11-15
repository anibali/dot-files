# .zshrc
# ------
# Requirements:
# * most (http://www.jedsoft.org/most)
# * command-not-found
# * oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh)
# * aiden.theme (https://github.com/dismaldenizen/dot-files)

# Path to your oh-my-zsh configuration
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="aiden"

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/arm-elf/bin:/var/lib/gems/1.8/bin

# Enable package suggestions when a command is not found
source /etc/zsh_command_not_found

# Set the default pager to "most"
export PAGER="/usr/bin/most -s"
export MANPAGER="/usr/bin/most -s"

# Add some colour to commands
alias dir='dir --color'
alias spec='spec --color'

