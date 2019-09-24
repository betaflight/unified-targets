test: check-unified-target-naming

check-unified-target-naming:
	@for target_config in configs/default/*; do \
		BOARD_NAME=$$(sed -n 's/^ *board_name \([^#]\+\).*$$/\1/p' $${target_config} | sed -e 's/[[:space:]]*$$//'); \
		MANUFACTURER_ID=$$(sed -n 's/^ *manufacturer_id \+\([^#]\{1,4\}\).*$$/\1/p' $${target_config} | sed -e 's/[[:space:]]*$$//'); \
		FILE_NAME=$$(basename $${target_config}); \
		\
		if [ $$(printf %s "$${BOARD_NAME}" | grep -c .) -gt 1 ]; then \
			echo "More than one board_name found in Unified Target configuration $${target_config}."; \
			exit 1; \
		fi; \
		\
		if [ $$(printf %s "$${MANUFACTURER_ID}" | grep -c .) -gt 1 ]; then \
			echo "More than one manufacturer_id found in Unified Target configuration $${target_config}."; \
			exit 1; \
		fi; \
		\
		if [ "$${FILE_NAME}" != "$${BOARD_NAME}.config" ] && [ "$${FILE_NAME}" != "$${MANUFACTURER_ID}_$${BOARD_NAME}.config" ]; then \
			echo "File name does not match board name ($${BOARD_NAME}) / manufacturer id ($${MANUFACTURER_ID}) in Unified Target configuration $${target_config}."; \
			exit 1; \
		fi; \
	done
