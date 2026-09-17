#!/bin/zsh
# Installs the "Copy Path" Finder Quick Action into ~/Library/Services.
set -e
cd "$(dirname "$0")"
mkdir -p ~/Library/Services
rm -rf ~/Library/Services/"Copy Path.workflow"
cp -R "Copy Path.workflow" ~/Library/Services/
# Ask the services system to pick up the new item without a logout.
/System/Library/CoreServices/pbs -update
echo "Installed: ~/Library/Services/Copy Path.workflow"
