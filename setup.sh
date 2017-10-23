#!/bin/bash -e

# ask the user what banner they'd like, default to the hostname
read -e -p "Banner (defaults to hostname): " banner

# make sure the things happy-banner requires are installed
which git     >> /dev/null || sudo apt-get install -y git     >> /dev/null
which bc      >> /dev/null || sudo apt-get install -y bc      >> /dev/null
which toilet  >> /dev/null || sudo apt-get install -y toilet  >> /dev/null
which figlet  >> /dev/null || sudo apt-get install -y figlet  >> /dev/null
which lolcat  >> /dev/null || sudo apt-get install -y lolcat  >> /dev/null
which fortune >> /dev/null || sudo apt-get install -y fortune >> /dev/null

# copy the font over
sudo mkdir -p /usr/share/figlet
sudo cp happy-banner/happy-banner-font.flf /usr/share/figlet/

# generate the command that shows the banner
cmd="BANNER=$banner source $(dirname $0)/banner.sh"

#add it to profile to auto-run on login
grep -q "happy-banner.sh" ~/.bashrc || echo "$cmd" >> ~/.bashrc

# confirm that we're all-g
echo 'happy-banner set-up! reload your terminal (or `source ~/.bashrc`) to see'
