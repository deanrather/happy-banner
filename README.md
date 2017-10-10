# happy-banner

a happy banner to put at the top of your terminal

## Setup

```
read -e -p "Banner:" -i "[hostname]" BANNER &&
which git >> /dev/null || sudo apt-get install -y git &&
git clone "https://github.com/deanrather/happy-banner.git" ~/.happy-banner &&
~/.happy-banner/setup.sh
```
