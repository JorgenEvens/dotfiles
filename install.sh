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

git submodule update --init

for file in $TO_LINK; do
    symlink "$file"
done

symlink vim .vim
symlink bin .bin

if [ `uname` = "Linux" ]; then
    # Update to latest git
    sudo add-apt-repository -yu ppa:git-core/ppa
    sudo apt-get install git

    # Install hub
    curl -L https://github.com/github/hub/releases/download/v2.2.9/hub-linux-amd64-2.2.9.tgz | tar -xz -C /tmp
    sudo /tmp/hub-linux-amd64-*/install

    # Install latest tmux
    sudo add-apt-repository -yu ppa:pi-rho/dev
    sudo apt-get install tmux-next
    sudo update-alternatives --install /usr/bin/tmux tmux /usr/bin/tmux-next 60

    # Install neovim
    sudo add-apt-repository -yu ppa:neovim-ppa/stable
    sudo apt-get install neovim python-dev python-pip
    sudo pip install neovim

    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60

    # Install patched powerline fonts
    mkdir -p ~/.fonts/
    git clone https://github.com/powerline/fonts.git /tmp/powerline-fonts
    cp -a /tmp/powerline-fonts/SourceCodePro/* ~/.fonts/
    sudo fc-cache -f -v
fi

# Install autoenv
git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv

# Install Tmux Plugin Manager
mkdir -p ${DIR}/tmux/plugins
git clone https://github.com/tmux-plugins/tpm ${DIR}/tmux/plugins/tpm

# Setup NeoVIM
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim

# Install VI plugins
cd `dirname $SCRIPT_PATH`
git submodule update --init
vim +PluginInstall +qa

# Configure GIT
git config --global user.email "jorgen@evens.eu"
git config --global user.name "Jorgen Evens"
git config --global commit.gpgsign true
