#bin/sh

curl -s https://api.github.com/repos/hoppscotch/releases/releases/latest \
| grep "browser_download_url.*linux.*x86_64.*AppImage" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi - -O hoppscotch.AppImage

chmod +x hoppscotch.AppImage

flatpak run it.mijorus.gearlever --integrate hoppscotch.AppImage