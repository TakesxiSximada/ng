# Miniconda2-latest-MacOSX-x86_64.sh
# Miniconda3-latest-MacOSX-x86_64.sh
MINICONDA_DOWNLOAD_URL := https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
MINICONDA_INSTALLER = $(CURDIR)/var/cache/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
MINICONDA_LIB_PATH = $(CURDIR)/var/lib/miniconda3
MINICONDA_CONF_FILE := $(NG_CONF_DIR)/miniconda3.sh

.PHONY: conda
conda: $(MINICONDA_LIB_PATH) $(MINICONDA_CONF_FILE)
	@# Install conda environent

	echo "complete"

$(MINICONDA_INSTALLER):
	mkdir -p `dirname $(MINICONDA_INSTALLER)`
	curl -L $(MINICONDA_DOWNLOAD_URL) -o $(MINICONDA_INSTALLER)

$(MINICONDA_LIB_PATH): $(MINICONDA_INSTALLER)
	sh $(MINICONDA_INSTALLER)

$(MINICONDA_CONF_FILE):
	echo "export PATH=\"$(MINICONDA_LIB_PATH)/bin:\$$PATH\"" > $(MINICONDA_CONF_FILE)
