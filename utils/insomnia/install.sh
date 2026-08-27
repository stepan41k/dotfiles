#bin/sh
curl -s https://api.github.com/repos/Kong/insomnia/releases/latest \
| grep "browser_download_url.*\.rpm" \
| head -n 1 \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi - -O insomnia.rpm

sudo dnf install ./insomnia.rpm

rm insomnia.rpm