checks: check-unified-target-naming

check-unified-target-naming:
	@for target_config in configs/default/*; do \
		BOARD_NAME=$$(sed -n 's/^board_name \([^ ]\+\).*$$/\1/p' $${target_config}); \
		FILE_NAME=$$(basename $${target_config}); \
		if [ -f $${target_config} ] && [ "$${FILE_NAME}" != "$${BOARD_NAME}.config" ]; then \
			echo "Invalid board name ($${BOARD_NAME}) in Unified Target configuration $${target_config}."; \
			exit 1; \
		fi; \
	done
