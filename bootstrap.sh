#! /usr/bin/env bash
which brew > /dev/null
if [ "0" != "$?" ]
then
    echo "Failed: Need homebrew. See http://brew.sh/"
    exit 1
fi


which go > /dev/null
if [ "0" != "$?" ]
then
    echo "Failed: Need Golang. \`brew install go\`"
    exit 1
fi

GOPATH=$PWD
NG_REPO=github.com/TakesxiSximada/ng
NG_ROOT=$GOPATH/src/$NG_REPO

go get -u -d $NG_REPO

if [ -e ng.mk ]
then
    echo "WARNING: ng.mk already exist"
else
    cp $NG_ROOT/ng.mk.example ng.mk
fi

if [ -e Makefile ]
then
    echo "WARNING: Makefile already exist"
else
    ln -sf ng.mk Makefile
fi
make create
