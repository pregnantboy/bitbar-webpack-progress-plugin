#!/bin/bash
# for use with: https://github.com/pregnantboy/bitbar-webpack-progress-plugin

color_red="😡 | color=#ff0000 dropdown=false"
color_yellow="⏳ | color=#ffa500 dropdown=false"
color_green="😀 | color=#008000 dropdown=true"

webpack_status="/tmp/webpack-status"

semaphore=0

webpack_status="`/usr/local/bin/node -e 'console.log(require("os").tmpdir())'`/webpack-progress"

semaphore=0

if [ -f $webpack_status ]; then
  semaphore=`cat $webpack_status`
fi

semaphore_color=$color_yellow

# -1 red, 0 yellow, 1 green
case $semaphore in
-*)
  # Red
  semaphore_color="$((-$semaphore/100)) $color_red"
  ;;
100)
  # Green
  semaphore_color="$color_green"
  ;;
*)
  # Orange
  semaphore_color="$semaphore $color_yellow"
  ;;
esac

echo "$semaphore_color"
echo "---"
echo "Clear Webpack Status | terminal=false bash=rm param1=-f param2='$webpack_status'"