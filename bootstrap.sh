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
NG_ROOT=$GOAPTH/src/TakesxiSximada/ng/ng

go get -u -d github.com/TakesxiSximada/ng
ln -sf $NG_ROOT/ng.mk.example Makefile
make create
