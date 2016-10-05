RBENV_REPOSITORY = https://github.com/rbenv/rbenv.git
RBENV_LIB_PATH = $(CURDIR)/var/lib/rbenv
RBENV_CONF_FILE = $(NG_CONF_DIR)/100-rbenv.sh
RUBY_BUILD_REPOSITORY = https://github.com/rbenv/ruby-build.git
RUBY_BUILD_LIB_PATH = $(RBENV_LIB_PATH)/plugins/ruby-build

.PHONY: rbenv
rbenv: $(RBENV_LIB_PATH) $(RBENV_CONF_FILE)
	@# Install rbenv

	ln -sf $(RBENV_LIB_PATH) ~/.rbenv
	echo "complete"

$(RBENV_LIB_PATH):
	git clone $(RBENV_REPOSITORY) $(RBENV_LIB_PATH)
	cd $(RBENV_LIB_PATH) && src/configure && make -C src

$(RBENV_CONF_FILE):
	echo "export PATH=\"$(RBENV_LIB_PATH)/bin:\$$PATH\"\n" > $(RBENV_CONF_FILE)
	echo "RBENV_ROOT=$(RBENV_LIB_PATH)\n" >> $(RBENV_CONF_FILE)
	echo "eval \"\$$(rbenv init -)\"\n" >> $(RBENV_CONF_FILE)


.PHONY: ruby-build
ruby-build: $(RUBY_BUILD_LIB_PATH)
	@# Install ruby-build

	echo "complete"

$(RUBY_BUILD_LIB_PATH):
	mkdir -p `dirname $(RUBY_BUILD_LIB_PATH)`
	git clone $(RUBY_BUILD_REPOSITORY) $(RUBY_BUILD_LIB_PATH)
	cd $(RUBY_BUILD_LIB_PATH) && PREFIX=$(NG_LOCAL) sh install.sh
