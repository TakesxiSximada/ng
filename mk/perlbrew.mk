PERLBREW_INSTALLER_URL := http://install.perlbrew.pl
PERLBREW_INSTALLER := $(CURDIR)/var/cache/install.perlbrew.pl
PERLBREW_REPOSITORY := https://github.com/rbenv/ruby-build.git
PERLBREW_LIB_PATH := $(CURDIR)/var/lib/perlbrew
PERLBREW_SCRIPT := $(PERLBREW_LIB_PATH)/etc/bashrc
PERLBREW_SCRIPT_NG := $(NG_CONF_DIR)/100-perlbrew.sh

.PHONY: perlbrew
perlbrew: $(PERLBREW_SCRIPT_NG)
	@# Install perlbrew (BUT IT DOES NOT WORKING)
	echo "complete"

$(PERLBREW_INSTALLER):
	mkdir -p `dirname $(PERLBREW_INSTALLER)`
	curl -kL $(PERLBREW_INSTALLER_URL) -o $(PERLBREW_INSTALLER)

$(PERLBREW_LIB_PATH): $(PERLBREW_INSTALLER)
	PERLBREW_ROOT=$(PERLBREW_LIB_PATH) sh $(PERLBREW_INSTALLER)

$(PERLBREW_SCRIPT_NG): $(PERLBREW_LIB_PATH)
	echo "# perbrew ng settings\n" > $(PERLBREW_SCRIPT_NG)
	echo "source $(PERLBREW_SCRIPT)\n" >> $(PERLBREW_SCRIPT_NG)
	echo "PERL_CPANM_OPT=--local-lib=$(PERLBREW_LIB_PATH)\n" >> $(PERLBREW_SCRIPT_NG)
	echo "PATH=$(PERLBREW_LIB_PATH)/bin:$$PATH\n" >> $(PERLBREW_SCRIPT_NG)
	echo "export PERLBREW_ROOT=$(PERLBREW_LIB_PATH)\n" >> $(PERLBREW_SCRIPT_NG)
	echo "export PERLBREW_HOME=$(PERLBREW_LIB_PATH)\n" >> $(PERLBREW_SCRIPT_NG)
