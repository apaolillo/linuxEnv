#! /bin/bash
# setupLinuxWorkstationEnv.sh

set -e

# Important variables
EMAIL=antonio.paolillo@ulb.ac.be
DEVENV_REPO_DIR=.
CONFIGFILES_DIR=$DEVENV_REPO_DIR/configFiles

## List of packages
# Main packages
ALL_PACKAGES="vim git xchat"
# Temporary: to integrate the dropbox icon in the Gnome Unity toolbar
ALL_PACKAGES="$ALL_PACKAGES libappindicator1"


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

# Configure machine for HIPPEROS
GIT_REPOS=$HOME/git
returnDir=`pwd`
mkdir -p $GIT_REPOS
cd $GIT_REPOS
git clone ssh://git@www.itial.be:2002/hipperosDevEnv
cd $GIT_REPOS/hipperosDevEnv
bash setupHipperosDevEnv.sh
cd $returnDir

# Configure gnome terminal
cp $CONFIGFILES_DIR/%gconf.xml $HOME/.gconf/apps/gnome-terminal/keybindings/.

# Color terminal with dark solarized
returnDir=`pwd`
mkdir -p $GIT_REPOS/configRepos
cd $GIT_REPOS/configRepos
git clone https://github.com/sigurdga/gnome-terminal-colors-solarized.git
cd gnome-terminal-colors-solarized
./set_dark.sh
cd $returnDir

