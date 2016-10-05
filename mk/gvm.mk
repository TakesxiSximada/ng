GVM_INSTALLER_URL := https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer
GVM_INSTALLER := $(CURDIR)/var/cache/gvm/gvm-installer
GVM_LIB_PATH := $(CURDIR)/var/lib/gvm
GVM_SCRIPT := $(GVM_LIB_PATH)/scripts/gvm
GVM_SCRIPT_NG := $(NG_CONF_DIR)/gvm
GVM_BRANCH := master
GOROOT_BOOTSTRAP_VERSION=go1.4.2
GOROOT_BOOTSTRAP := $(GVM_LIB_PATH)/gos/$(GOROOT_BOOTSTRAP_VERSION)
GOROOT_BOOTSTRAP_NG := $(NG_CONF_DIR)/goroot-bootstrap.sh

.PHONY: gvm
gvm: $(GVM_SCRIPT_NG) $(GOROOT_BOOTSTRAP_NG)
	@# Install gvm
	echo "complete"

$(GVM_INSTALLER):
	mkdir -p `dirname $(GVM_INSTALLER)`
	curl -L $(GVM_INSTALLER_URL) -o $(GVM_INSTALLER)

$(GVM_SCRIPT): $(GVM_INSTALLER)
	sh $(GVM_INSTALLER) $(GVM_BRANCH) `dirname $(GVM_LIB_PATH)`

$(GVM_SCRIPT_NG): $(GVM_SCRIPT)
	echo "source $(GVM_SCRIPT)" > $(GVM_SCRIPT_NG)

$(GOROOT_BOOTSTRAP_NG): $(GOROOT_BOOTSTRAP)
	echo "export GOROOT_BOOTSTRAP=$(GOROOT_BOOTSTRAP)" > $(GOROOT_BOOTSTRAP_NG)

$(GOROOT_BOOTSTRAP):
	source $(GVM_SCRIPT) && gvm install $(GOROOT_BOOTSTRAP_VERSION)
