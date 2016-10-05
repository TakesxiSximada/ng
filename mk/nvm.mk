NVM_REPOSITORY := git://github.com/creationix/nvm.git
NVM_LIB_PATH := $(CURDIR)/var/lib/nvm
NVM_SCRIPT_NG := $(NG_CONF_DIR)/nvm.sh
NVM_SCRIPT := $(NVM_LIB_PATH)/nvm.sh
NVM_REQUIRE_SED := /usr/local/bin/gsed
NVM_REQUIRE_SED_PKG := gnu-sed

.PHONY: nvm
nvm: $(NVM_SCRIPT_NG)
	@# Install nvm
	mkdir -p $(CURDIR)/var/cache/npm
	echo "complete"

$(NVM_REQUIRE_SED):
	brew install $(NVM_REQUIRE_SED_PKG)

$(NVM_LIB_PATH): $(NVM_REQUIRE_SED)
	git clone $(NVM_REPOSITORY) $(NVM_LIB_PATH)
	cd $(NVM_LIB_PATH) && git checkout `git describe --abbrev=0 --tags`

$(NVM_SCRIPT_NG): $(NVM_LIB_PATH)
	echo "source $(NVM_SCRIPT)" > $(NVM_SCRIPT_NG)
