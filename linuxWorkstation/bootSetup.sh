#! /bin/bash
# This script provides the first commands to execute when installing a new machine used as 'workstation'.

ssh-keygen -t rsa -C "antonio.paolillo@ulb.ac.be"

sudo apt-get update
sudo apt-get install -y git
git config --global user.name "Antonio Paolillo"
git config --global user.email "antonio.paolillo@ulb.ac.be"
mkdir -p ~/git

echo "You must now provide the new SSH public key to the Github admin panel
(https://github.com/settings/ssh) in order to have access to private
repositories. After that, you will be able to launch deploy scripts.

The public key is the following:
"
cat ~/.ssh/id_rsa.pub

