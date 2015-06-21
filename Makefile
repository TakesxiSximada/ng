# -*- coding: utf-8 -*-
# Need virtualenv
.PHONY: all clean build rebuild

all: env/bin/pip bin/buildout build
	@echo "**** GOGO *****"
	@echo "buildout finished..."

clean:
	@echo "**** CLEAN *****"
	rm -rf bin parts eggs develop-eggs .installed env bootstrap.py

build: bin/buildout
	@echo "**** EXECUTE buildout *****"
	bin/buildout -vc buildout.cfg

rebuild: clean build
	@echo "**** REBUILD FINISHED *****"


# ---------------------------------
bin/buildout: env/bin/pip bootstrap.py
	@echo "**** EXECUTE bootstrap.py *****"
	cat bootstrap.py | python

bootstrap.py:
	@echo "**** DONWLOAD: bootstrap.py *****"
	curl https://raw.githubusercontent.com/buildout/buildout/master/bootstrap/bootstrap.py > bootstrap.py

env/bin/pip:
	@echo "**** CREATE env *****"
	virtualenv --no-site-packages env
	env/bin/pip install -U setuptools
