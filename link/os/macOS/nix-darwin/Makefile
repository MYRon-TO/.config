deploy:
	nix build .#darwinConfigurations.TOS-MAC.system \
	   --extra-experimental-features 'nix-command flakes'

	sudo -E ./result/sw/bin/darwin-rebuild switch --flake .#TOS-MAC
