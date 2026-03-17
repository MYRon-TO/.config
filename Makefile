.PHONY: deploy

# Detect Operating System
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	OS_TYPE := macOS
else ifeq ($(UNAME_S),Linux)
	OS_TYPE := linux
else
	OS_TYPE := unknown
endif

deploy:
	@echo "Detected OS: $(UNAME_S) -> Target: $(OS_TYPE)"
	
	@echo "Deploying home configurations..."
	@if [ -d "link/home" ]; then \
		find link/home -mindepth 1 -maxdepth 1 | while read src; do \
			filename=$$(basename "$$src"); \
			target="$(HOME)/$$filename"; \
			if [ -h "$$target" ]; then \
				echo "Removing existing symlink $$target"; \
				rm "$$target"; \
			elif [ -e "$$target" ]; then \
				echo "Backing up $$target to $$target.bk"; \
				mv "$$target" "$$target.bk"; \
			fi; \
			echo "Linking $$(pwd)/$$src to $$target"; \
			ln -s "$$(pwd)/$$src" "$$target"; \
		done; \
	else \
		echo "Warning: link/home directory not found."; \
	fi

	@echo "Deploying OS-specific configurations to ~/.config..."
	@if [ "$(OS_TYPE)" = "unknown" ]; then \
		echo "Skipping OS-specific copy: Unknown OS $(UNAME_S)"; \
	elif [ -d "link/os/$(OS_TYPE)" ]; then \
		mkdir -p $(HOME)/.config; \
		find link/os/$(OS_TYPE) -mindepth 1 -maxdepth 1 | while read src; do \
			filename=$$(basename "$$src"); \
			target="$(HOME)/.config/$$filename"; \
			if [ -h "$$target" ]; then \
				echo "Removing existing symlink $$target"; \
				rm "$$target"; \
			elif [ -e "$$target" ]; then \
				echo "Backing up $$target to $$target.bk"; \
				mv "$$target" "$$target.bk"; \
			fi; \
			echo "Linking $$(pwd)/$$src to $$target"; \
			ln -s "$$(pwd)/$$src" "$$target"; \
		done; \
	else \
		echo "Warning: link/os/$(OS_TYPE) directory not found."; \
	fi

	@echo "Deployment complete."