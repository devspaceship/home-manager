#!/usr/bin/env bash
PLUGIN_DIR="$CONFIG_DIR/plugins"

# Colors
bar_color=0x01000000
highlight_color=0xff00b7ff

# Bar Options
bar_options=(
  color="$bar_color"
  position=top
  height=32
  margin=0
  y_offset=0
  corner_radius=0
  border_width=0
  blur_radius=64
  padding_left=4
  padding_right=4
  font_smoothing=on
)
sketchybar --bar "${bar_options[@]}"

# Default Item Properties
default=(
  padding_left=4
  padding_right=4
  icon.font="FiraCode Nerd Font Mono:Retina:22"
  label.font="FiraCode Nerd Font Mono:Retina:17"
  icon.color=0xffffffff
  label.color=0xffffffff
  icon.highlight_color="$highlight_color"
  label.highlight_color="$highlight_color"
  icon.padding_left=4
  icon.padding_right=4
  label.padding_left=4
  label.padding_right=4
)
sketchybar --default "${default[@]}"

# Aerospace
sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
  sketchybar --add item "space.$sid" left \
    --subscribe "space.$sid" aerospace_workspace_change \
    --set "space.$sid" \
    icon.drawing=off \
    label="$sid" \
    click_script="aerospace workspace $sid" \
    script="$PLUGIN_DIR/aerospace.sh $sid"
done

sketchybar --set space.A \
  icon= \
  icon.drawing=on \
  label.drawing=off \
  --set space.M \
  icon= \
  icon.drawing=on \
  label.drawing=off \
  --set space.S \
  icon= \
  icon.drawing=on \
  label.drawing=off \
  --set space.T \
  icon= \
  icon.drawing=on \
  label.drawing=off \
  --set space.Y \
  icon= \
  icon.drawing=on \
  label.drawing=off

# Font App
sketchybar --add item chevron left \
  --set chevron icon= label.drawing=off \
  --add item front_app left \
  --set front_app icon.drawing=off script="$PLUGIN_DIR/front_app.sh" \
  --subscribe front_app front_app_switched

# Right Items
sketchybar --add item clock right \
  --set clock update_freq=10 icon= script="$PLUGIN_DIR/clock.sh" \
  --add item volume right \
  --set volume script="$PLUGIN_DIR/volume.sh" \
  --subscribe volume volume_change \
  --add item battery right \
  --set battery update_freq=120 script="$PLUGIN_DIR/battery.sh" \
  --subscribe battery system_woke power_source_change

##### Force all scripts to run the first time (never do this in a script) #####
sketchybar --update
