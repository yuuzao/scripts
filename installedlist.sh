#!/usr/bin/bash
# regularly export all installed packages
# todo system detection
# Works only on a Manjaro system at this momment

log=$HOME/log/installedlist.log
if [[ ! $BACKUP_DIR ]]; then
    echo -e "env not set yet, exit..." >>$log 2>&1
    exit 1
fi
cd $BACKUP_DIR
comm -23 <(pacman -Qeq | sort) <(pacman -Qmq | sort) >pkglist
pacman -Qqem > aurlist
echo "$(date)" >> $log 2>&1

if [[ -z $(git diff) ]]
then
    echo "Nothing new today..." >> $log 2>&1
else
    git diff >> $log 2>&1
fi
echo "----------" >> $log 2>&1