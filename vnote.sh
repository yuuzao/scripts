#!/bin/bash

root_dir=$HOME/Documents/vnote_notebooks
remote="https://github.com/yuuzao/vnote.git"
log=$HOME/log/vnote_init.log

if [[ ! -e $log ]]; then
    mkdir -p "$(dirname $log)" && touch $log
    echo "creating log at $log" 2>&1 | tee -a $log

    echo "the root directory of vnote is $root_dir" 2>&1 | tee -a $log
    echo "the repository is $remote" 2>&1 | tee -a $log
fi

if [[ ! -d $root_dir ]]; then
    mkdir -p $(dirname $root_dir)
    echo "cloning from remote repository..." 2>&1 | tee -a $log
    git clone $remote $root_dir 2>&1 | tee -a $log
fi

cd $root_dir

if [[ ! -d $root_dir/.git ]]; then
    echo "initializing for git..."
    git init 2>&1 | tee -a $log
    git remote add origin $remote 2>&1 | tee -a $log
    git add . 2>&1 | tee -a $log
    git commit -m 'init' 2>&1 | tee -a $log
    git pull origin master --allow-unrelated-histories 2>&1 | tee -a $log
fi

echo '--------------------' 2>&1 | tee -a $log
echo -e "$(date)\nchecking git status..." 2>&1 | tee -a $log

if [[ -n $(git diff HEAD origin/master) ]]; then
    git pull origin master 2>&1 | tee -a $log
fi

git status 2>&1 | tee -a $log

if [[ -n $(git status -s) ]]; then
    git add . 2>&1 | tee -a $log
    git commit -m 'committed by script' 2>&1 | tee -a $log
    git push -u origin master  2>&1 | tee -a $log
echo '--------------------' 2>&1 | tee -a $log
fi