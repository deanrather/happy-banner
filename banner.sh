#!/bin/bash
# banner.sh

# Clear default banner
clear



# takes a number between 0 - 100, returns that colour in a number
# 0  - 70  - green
# 71 - 80  - yellow
# 80 - 100 - red
colour_percentage()
{
    # if no args, return
    if [ $# -eq 0 ]
    then
        return
    fi

    # if non integer, echo it as-is
    if ! [ "$1" -eq "$1" ]
    then
        echo "$1"
        return
    fi

    w="\e[0m"
    g="\e[0;32m";
    y="\e[0;33m";
    r="\e[0;31m";

    if   [ "$1" -lt "71" ]; then echo -en "$g$1%$w";
    elif [ "$1" -gt "80" ]; then echo -en "$r$1%$w";
    else                         echo -en "$y$1%$w"; fi
}

if [ -z "$BANNER" ]
then
  # banner="$(whoami) @ $(hostname)"
  banner="$(hostname)"
  strlen=${#banner}
  colwidth=$(($strlen*6))
else
  banner="$BANNER"
  colwidth=80
fi

termwidth=$(tput cols)

# echo "colwidth=$colwidth"
# echo "termwidth=$termwidth"

if (( colwidth <= termwidth )); then
  # see `ll /usr/share/figlet/*.flf` for list of fonts
  # or http://www.figlet.org/examples.html
  # see `toilet -F` list for list of filters
  toilet -F border -f happy-banner-font -w "$colwidth" "  $banner  " | lolcat -S 108 -s 0.1
  # toilet -F border -f standard "  $banner  "
else
  echo ""
  echo "      $banner" | lolcat
  echo ""
fi

# Show Stats
tput sc # remember cursor position so we can overwrite the following output
echo "      Gathering System Stats...."
read cpu_use_total  < <(cat /proc/loadavg | cut -f 3 -d ' ')
read cpu_core_count < <(grep -c ^processor /proc/cpuinfo)
read cpu_use_total  < <(echo $cpu_use_total*100/$cpu_core_count | bc)
read disk_usage     < <(df | grep ^\/dev.*/\$ | awk '{print $5}' | grep -Po '[0-9]+')
read mem_usage      < <(free | grep Mem | awk '{print int($3/$2 * 100)}')
read mem_available  < <(cat /proc/meminfo | grep ^MemTotal | grep -Po [0-9]+ | awk '{$1=$1/1024^2; printf("%.1fGB",$1)}')
read hdd_available  < <(df | grep ^\/dev.*/\$ | awk '{print int($4/(1024^2)) "GB"}')
read cpu_speed      < <(cat /proc/cpuinfo | grep -Po [0-9\.]+GHz)
cpu_description="${cpu_core_count}x$cpu_speed"
uptime=$(uptime | cut -f 1 -d ',' | cut -f 2 -d 'p' | xargs)
# 18:15:13 up  9:33,  1 user,  load average: 1.31, 1.12, 0.77
tput rc # put the cursor back to where it was
echo -n " "
echo -n "     $cpu_description CPU $(colour_percentage $cpu_use_total)"
echo -n "     $mem_available RAM $(colour_percentage $mem_usage)"
echo -n "     $hdd_available HDD $(colour_percentage $disk_usage)"
echo -n "     UP $uptime"
echo ""
echo ""
unset cpu_use_total cpu_core_count cpu_use_total disk_usage mem_usage mem_available hdd_available cpu_speed cpu_description uptime

name=$(git config --global user.name)
onSince=$(last -R $USER | grep -Eo "$(date +'%a %b %d') [0-9]+:[0-9]+" | tail -n 1 | grep -Eo "[0-9]+:[0-9]+")
pstree_output=$(pstree -s $$)
where=$(echo "$pstree_output" | sed 's/---pstree//' | sed 's/---bash//' | sed 's/---/ -> /g')

# Show Welcome Message

echo "      $(date) (since $onSince)"
echo "      Welcome, $name"
echo "      You are here: $where"
echo ""
fortune | fold -w 70 -s | sed  's/^/      /'
echo ""
