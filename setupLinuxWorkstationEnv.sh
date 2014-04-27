#! /bin/bash
# setupLinuxWorkstationEnv.sh

set -e

EMAIL=antonio.paolillo@ulb.ac.be
ALL_PACKAGES=vim git

if [ ! -f ~/.ssh/id_rsa ]; then
    echo "There is no ssh key defined in ~/.ssh\nPlease use the following command:\n  ssh-keygen -t rsa -C \"$EMAIL\""
    exit -1
fi

sudo apt-get update
sudo apt-get install -y --no-install-recommends $ALL_PACKAGES

