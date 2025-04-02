#!/usr/bin/env bash
PLUGIN_DIR="$CONFIG_DIR/plugins"

# Colors
bar_color=0x01000000
border_color=0xff00bb33

# Bar Options
bar_options=(
  color="$bar_color"
  border_color="$border_color"
  position=top
  height=40
  margin=10
  y_offset=10
  corner_radius=20
  border_width=2
  blur_radius=64
  padding_left=0
  padding_right=0
  font_smoothing=on
)
sketchybar --bar "${bar_options[@]}"

# Default Item Properties
default=(
  padding_left=5
  padding_right=5
  icon.font="FiraCode Nerd Font Mono:Retina:22"
  label.font="FiraCode Nerd Font Mono:Retina:17"
  icon.color=0xffffffff
  label.color=0xffffffff
  icon.padding_left=4
  icon.padding_right=4
  label.padding_left=4
  label.padding_right=4
)
sketchybar --default "${default[@]}"

# Aerospace
sketchybar --add event aerospace_workspace_change

space=(
  padding_left=0
  padding_right=0
  icon.padding_right=0
  label.padding_left=0
  background.color=0x000000
  background.border_color="$border_color"
  background.border_width=2
  background.corner_radius=20
  background.height=40
  background.drawing=off
)
for sid in $(aerospace list-workspaces --all); do
  sketchybar --add item "space.$sid" left \
    --subscribe "space.$sid" aerospace_workspace_change \
    --set "space.$sid" \
    "${space[@]}" \
    label="$sid" \
    click_script="aerospace workspace $sid" \
    script="$PLUGIN_DIR/aerospace.sh $sid"
done

# sketchybar --set space.A \
#   icon= \

sketchybar --set space.1 \
  icon.padding_left=20 \
  --set space.T \
  icon= \
  icon.padding_right=10

##### Adding Left Items #####
# We add some regular items to the left side of the bar, where
# only the properties deviating from the current defaults need to be set

sketchybar --add item chevron left \
  --set chevron icon= label.drawing=off \
  --add item front_app left \
  --set front_app icon.drawing=off script="$PLUGIN_DIR/front_app.sh" \
  --subscribe front_app front_app_switched

##### Adding Right Items #####
# In the same way as the left items we can add items to the right side.
# Additional position (e.g. center) are available, see:
# https://felixkratz.github.io/SketchyBar/config/items#adding-items-to-sketchybar

# Some items refresh on a fixed cycle, e.g. the clock runs its script once
# every 10s. Other items respond to events they subscribe to, e.g. the
# volume.sh script is only executed once an actual change in system audio
# volume is registered. More info about the event system can be found here:
# https://felixkratz.github.io/SketchyBar/config/events

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
