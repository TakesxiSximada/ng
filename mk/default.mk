############## COPY #############################
# NG_MK_PATH := $(CURDIR)/home/src/ng/mk
# NG_CONF_ROOT_CONF := $(CURDIR)/etc/ng
# NG_CONF_DIR := $(CURDIR)/etc/ng.d
# NG_LOCAL := $(CURDIR)/local
# include $(NG_MK_PATH)/*.mk
#
# .DEFAULT_GOAL_NAME := help
#
# .PHONY: help
# help:
# 	@# display usage
#
# 	@unmake $(MAKEFILE_LIST)
#
#################################################

.PHONY: create
create:
	mkdir -p \
		etc \
		home \
		local/bin \
		var/cache/ \
		var/cache/download \
		var/cache/wheelhouse \
		var/src \
		var/lib \
		var/run \
		var/sock \
		var/log

	make config
	make conda
	make gvm
	make nvm
	make rbenv
	make ruby-build
	make perlbrew
	make gisting

.PHONY: config
config: $(NG_CONF_ROOT_CONF) $(NG_LOCAL_CONF_NG)
	@echo "completed ... $(NG_CONF_ROOT_CONF)"

$(NG_CONF_DIR):
	mkdir -p $(NG_CONF_DIR)

$(NG_CONF_ROOT_CONF): $(NG_CONF_DIR)
	echo 'script_dir=$$(cd $$(dirname $${BASH_SOURCE:-$$0}); pwd); for conf in `find $$script_dir/ng.d -type f`; do source $$conf; done ' > $(NG_CONF_ROOT_CONF)

$(NG_LOCAL_CONF_NG):
	echo "export PATH=\"$(NG_LOCAL)/bin:\$$PATH\"" > $(NG_LOCAL_CONF_NG)
