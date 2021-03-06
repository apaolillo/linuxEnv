#! /bin/bash
# setupLinuxWorkstationEnv.sh

set -e

# Important variables
EMAIL=apaolill@gmail.com
DEVENV_REPO_DIR=`pwd`
CONFIGFILES_DIR=$DEVENV_REPO_DIR/configFiles
GIT_REPOS=$HOME/git

## List of packages
# Main packages
ALL_PACKAGES="vim git xchat openssh-server meld gparted bpython"


function downloadAndInstallDeb
{
    package_name=$1
    package_url=$2
    returnDir=`pwd`
    cd /tmp
    wget -O /tmp/$package_name $package_url
    sudo dpkg -i /tmp/$package_name
}


# Check for SSH key
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "There is no ssh key defined in ~/.ssh\nPlease use the following command:\n  ssh-keygen -t rsa -C \"$EMAIL\""
    exit -1
fi

# Configure git
cp $CONFIGFILES_DIR/.gitconfig $HOME/.gitconfig

# Install all packages
sudo apt-get update
sudo apt-get install -y --no-install-recommends $ALL_PACKAGES

# Download ad install deb packages
downloadAndInstallDeb chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
downloadAndInstallDeb dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.6.0_amd64.deb

# Configure gnome terminal
TERMINAL_SHORTCUTS_DIR=$HOME/.gconf/apps/gnome-terminal/keybindings
mkdir -p $TERMINAL_SHORTCUTS_DIR
cp "$CONFIGFILES_DIR/%gconf.xml" $TERMINAL_SHORTCUTS_DIR/.

# Color terminal with dark solarized
mkdir -p $GIT_REPOS/configRepos
pushd $GIT_REPOS/configRepos
git clone https://github.com/sigurdga/gnome-terminal-colors-solarized.git
pushd gnome-terminal-colors-solarized
./set_dark.sh
popd
popd

