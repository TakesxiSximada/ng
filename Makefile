# -*- coding: utf-8 -*-
# Need virtualenv
.PHONY: all clean build rebuild

all: env bin/buildout build
	echo "buildout finished..."

clean:
	rm -rf bin parts eggs develop-eggs .installed env bootstrap.py

build: bin/buildout
	bin/buildout -c buildout.cfg

rebuild: clean build
	echo

bin/buildout: env bootstrap.py
	cat bootstrap.py | python

bootstrap.py:
	curl https://raw.githubusercontent.com/buildout/buildout/master/bootstrap/bootstrap.py > bootstrap.py

env:
	virtualenv --no-site-packages env
	env/bin/pip install -U setuptools
