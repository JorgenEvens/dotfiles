#!/bin/sh

# Get the absolute path of the script that has been called.
SCRIPT_PATH="$HOME/.zshrc"
while [ -h "$SCRIPT_PATH" ]; do SCRIPT_PATH=`readlink "$SCRIPT_PATH"`; done

DIR="`dirname $SCRIPT_PATH`/shell"

# User configuration
. ~/.private

export PATH=$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH

ENABLED=(nvm ssh ohmyzsh git alias sprinter workflow brew bubobox vim dokku autoenv applescript open node gpg)

for FILE in $ENABLED; do
    . "$DIR/$FILE"
done

export NVM_DIR="/Users/jorgen/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads rvm

export PATH="$HOME/.yarn/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin:"
