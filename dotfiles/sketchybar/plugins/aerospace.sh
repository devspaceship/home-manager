#!/usr/bin/env bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    background.drawing=on \
    icon.padding_left=20 \
    label.padding_right=20 \
    icon.font.size=32 \
    label.font.size=28
else
  sketchybar --set "$NAME" \
    background.drawing=off \
    icon.padding_left=10 \
    label.padding_right=10 \
    icon.font.size=22 \
    label.font.size=17
fi

if [ "$NAME" = "space.1" ]; then
  sketchybar --set space.1 \
    icon.padding_left=15
fi
