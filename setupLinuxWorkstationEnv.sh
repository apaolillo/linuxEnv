#! /bin/bash
# setupLinuxWorkstationEnv.sh

set -e

EMAIL=antonio.paolillo@ulb.ac.be
ALL_PACKAGES=vim git
DEVENV_REPO_DIR=.
CONFIGFILES_DIR=$DEVENV_REPO_DIR/configFiles

# Check for SSH key
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "There is no ssh key defined in ~/.ssh\nPlease use the following command:\n  ssh-keygen -t rsa -C \"$EMAIL\""
    exit -1
fi

# Configure git
cp $CONFIGFILES_DIR/.gitconfig $HOME/.gitconfig

# Install main packages
sudo apt-get update
sudo apt-get install -y --no-install-recommends $ALL_PACKAGES

# Configure machine for HIPPEROS
GIT_REPOS=$HOME/git
returnDir=`pwd`
mkdir -p $GIT_REPOS
cd $GIT_REPOS
git clone ssh://git@www.itial.be:2002/hipperosDevEnv
cd $GIT_REPOS/hipperosDevEnv
bash setupHipperosDevEnv.sh
cd $returnDir

