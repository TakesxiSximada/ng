GISTING_TEMPLATE := $(NG_MK_PATH)/../templates/gisting.sh
GISTING_CONF_FILE := $(NG_CONF_DIR)/100-gisting.sh

.PHONY: gisting
gisting: $(GISTING_CONF_FILE)
	@# Load gisting script

$(GISTING_CONF_FILE):
	if [ ! -e $(GISTING_TEMPLATE) ]; then echo "$(GISTING_TEMPLATE) Does not exists."; exit 1; fi
	cp $(GISTING_TEMPLATE) $(GISTING_CONF_FILE)
