#!/bin/bash -e
USAGE='setup.sh <dir> <banner>
eg: setup.sh ~/.happy-banner MY-BANNER'

if [ $# -lt 2 ]
then
	echo "usage: $USAGE"
	exit 1
fi

dir=$1
banner=$2

which git     >> /dev/null || sudo apt-get install -y git
which toilet  >> /dev/null || sudo apt-get install -y toilet
which lolcat  >> /dev/null || sudo apt-get install -y lolcat
which fortune >> /dev/null || sudo apt-get install -y fortune

echo "HAPPY_BANNER=$banner" >> ~/.bashrc
grep -q "happy-banner.sh" ~/.bashrc || echo "source $dir/banner.sh" >> ~/.bashrc

$dir/banner.sh

echo "happy-banner set-up!"
