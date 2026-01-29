# nix-shell -p pam_u2f
# mkdir -p ~/.config/Yubico
# pamu2fcfg > ~/.config/Yubico/u2f_keys
# add another yubikey (optional): pamu2fcfg -n >> ~/.config/Yubico/u2f_keys
# sudo cp /etc/pam.d/sudo /etc/pam.d/hyprlock
