#!/bin/sh

# Get the absolute path of the script that has been called.
SCRIPT_PATH="$HOME/.zshrc"
while [ -h "$SCRIPT_PATH" ]; do SCRIPT_PATH=`readlink "$SCRIPT_PATH"`; done

DIR="`dirname $SCRIPT_PATH`/shell"

# User configuration
. ~/.private

export PATH=$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH

ENABLED=(ohmyzsh git alias sprinter workflow docker nvm brew bubobox vim dokku autoenv applescript)

for FILE in $ENABLED; do
    . "$DIR/$FILE"
done

