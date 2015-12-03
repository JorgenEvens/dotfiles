#!/bin/sh

# Get the absolute path of the script that has been called.
SCRIPT_PATH="$0"
while [ -h "$SCRIPT_PATH" ]; do SCRIPT_PATH=`readlink "$SCRIPT_PATH"`; done

path() {
	local
	ORIG_DIR=`pwd`
	cd "$1"
	pwd
	cd "$ORIG_DIR"
}

DIR="$(path `dirname $0`)"

symlink() {
    local TARGET
    TARGET="$2"
    test -z "$TARGET" && TARGET="`basename $1`"
    TARGET="$HOME/$TARGET"

    echo "Linking $DIR/$1 to $TARGET"

    if [ -L "$TARGET" ]; then
        rm "$TARGET"
    fi

    if [ -f "$TARGET" ] || [ -d "$TARGET" ]; then
        mv $TARGET "${TARGET}.orig"
    fi

    ln -sf "$DIR/$1" "$TARGET"
}

TO_LINK=("$(cd $DIR; ls .*rc)")
TO_LINK+=" .tmux.conf"

for file in $TO_LINK; do
    symlink "$file"
done

symlink vim .vim
symlink bin .bin

# Install autoenv
git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv

# Install VI plugins
cd `dirname $SCRIPT_PATH`
git submodule update --init
vim +PluginInstall +qa
