PLUGIN_DIR="$CONFIG_DIR/plugins"

# Bar Options
bar_color=0x01000000
bar_border_color=0xff00bb33

bar_options=(
  color=$bar_color
  border_color=$bar_border_color
  position=top
  height=40
  margin=10
  y_offset=10
  corner_radius=20
  border_width=2
  blur_radius=64
  font_smoothing=on
)
sketchybar --bar "${bar_options[@]}"

# Default Item Properties
default=(
  padding_left=5
  padding_right=5
  icon.font="FiraCode Nerd Font Mono:Bold:17.0"
  label.font="FiraCode Nerd Font Mono:Bold:14.0"
  icon.color=0xffffffff
  label.color=0xffffffff
  icon.padding_left=4
  icon.padding_right=4
  label.padding_left=4
  label.padding_right=4
)
sketchybar --default "${default[@]}"

##### Adding Mission Control Space Indicators #####
# Let's add some mission control spaces:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item
# to indicate active and available mission control spaces.

# SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")
# for i in "${!SPACE_ICONS[@]}"; do
#   sid="$(($i + 1))"
#   space=(
#     space="$sid"
#     icon="${SPACE_ICONS[i]}"
#     icon.padding_left=7
#     icon.padding_right=7
#     background.color=0x40ffffff
#     background.corner_radius=5
#     background.height=25
#     label.drawing=off
#     script="$PLUGIN_DIR/space.sh"
#     click_script="yabai -m space --focus $sid"
#   )
#   sketchybar --add space space."$sid" left --set space."$sid" "${space[@]}"
# done

# Aerospace
sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
  sketchybar --add item "space.$sid" left \
    --subscribe "space.$sid" aerospace_workspace_change \
    --set "space.$sid" \
    background.color=0x44ffffff \
    background.corner_radius=5 \
    background.height=20 \
    background.drawing=off \
    label="$sid" \
    click_script="aerospace workspace $sid" \
    script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done

# sketchybar --set space.A \
#   icon= \
#   --set space.T \
#   icon= \

sketchybar --set space.T \
  icon=

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
