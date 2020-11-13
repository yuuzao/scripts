#!/usr/bin/sh
cd $BLOG
git fetch --all && git reset --hard 'origin/master' && git pull