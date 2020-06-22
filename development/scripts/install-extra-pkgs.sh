#!/bin/bash

cd $HOME

sudo apt-get update

wget -O discord.deb -L https://discord.com/api/download?platform=linux&format=deb
sudo dpkg -i discord.deb

wget -c  https://repo.skype.com/latest/skypeforlinux-64.deb -O skype.deb
sudo dpkg -i skype.deb

wget -O - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

wget -c https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.3-amd64.deb -O slack.deb
sudo dpkg -i slack.deb

wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O google-chrome.deb
sudo dpkg -i google-chrome.deb

sudo apt-get update
sudo apt install -y meld sublime-text

sudo apt install -f

rm -f *.deb
