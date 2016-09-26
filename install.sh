#!/bin/sh

set -e
set -u

setup(){
  dir=$HOME/osx-screenshot-launchd
  launchd=$HOME/Library/LaunchAgents

  if [ ! -d "$dir" ]; then
    git clone https://github.com/munisystem/osx-screenshot-launchd "$dir"
  fi

  if [ ! -d "$launchd" ]; then
    mkdir "$launchd"
  fi

  cp -f "$dir/take.screenshot.plist" "$launchd/take.screenshot.plist"
  reload "take.screenshot.plist"
}

# MEMO:
# すでにloadされている場合に再度同じラベルをloadするとerrorが発生する...
# が exit code 0 を返されるため、エラーハンドリングができない
load(){
  launchctl load ~/Library/LaunchAgents/$1
}

reload(){
  echo "Unload $1"
  launchctl unload ~/Library/LaunchAgents/$1
  echo "Load $1"
  load "$1"
}

setup
