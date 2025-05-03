#!/usr/bin/env bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    icon.highlight=on \
    label.highlight=on \
    icon.font.size=32 \
    label.font.size=28
else
  sketchybar --set "$NAME" \
    icon.highlight=off \
    label.highlight=off \
    icon.font.size=22 \
    label.font.size=17
fi
