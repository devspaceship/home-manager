border_color=0xff00bb33

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
  sketchybar --set "space.$sid" "${space[@]}"
done

sketchybar --set space.T \
  icon.padding_right=10
