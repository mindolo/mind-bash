#!/usr/bin/env bash

# Test if we have git
which git &> /dev/null
if [ $? -ne 0 ]; then
	echo "Please install git before running this installer."
	exit 1
fi

_repourl="https://github.com/andsens/homeshick.git"
_repodir="$HOME/.homesick/repos/homeshick"

echo "Installing homeshick..."
git clone "$_repourl" "$_repodir"
echo "Loading homeshick"
source "$_repodir"/homeshick.sh

homeshick clone mindolo/mind-bash
homeshick link mind-bash
exec bash
