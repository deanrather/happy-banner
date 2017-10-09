#!/bin/bash -e

which git     >> /dev/null || sudo apt-get install -y git
which toilet  >> /dev/null || sudo apt-get install -y toilet
which lolcat  >> /dev/null || sudo apt-get install -y lolcat
which fortune >> /dev/null || sudo apt-get install -y fortune

grep -q "happy-banner.sh" ~/.bashrc || echo -e "\nsource ~/.happy-banner/banner.sh" >> ~/.bashrc

source ~/.happy-banner/banner.sh

ehco "happy-banner set-up!"
