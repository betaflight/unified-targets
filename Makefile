checks: check-unified-target-naming

check-unified-target-naming:
	@for target_config in configs/default/*; do \
		if [ -f $${target_config} ] && [ $$(sed -n 's/board_name \([A-Z]*\)/\1/p' $${target_config}).config != $$(basename $${target_config}) ]; then \
			echo "Invalid board name ($$(sed -n 's/board_name \([A-Z]*\)/\1/p' $${target_config})) in Unified Target configuration $${target_config}."; \
			exit 1; \
		fi; \
	done
