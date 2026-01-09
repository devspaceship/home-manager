.PHONY: help
help:
	@echo "usage: make [command]"
	@echo "  help      Show this help message"
	@echo "  install   Install the flake"
	@echo "  update    Update the flake lock"
	@echo "  upgrade   Update the flake lock and install the flake"

.PHONY: install
install:
	home-manager switch \
		--flake ~/.config/home-manager#${DEVSPACE}

.PHONY: update
update:
	nix flake update \
		--flake ~/.config/home-manager

.PHONY: upgrade
upgrade: update install
