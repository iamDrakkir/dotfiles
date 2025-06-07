#!/bin/bash
bash <(curl https://updates.zen-browser.app/appimage.sh)
xdg-settings set default-web-browser ZenBrowser.desktop

echo "remember about:config zen.view.hide-window-controls"
