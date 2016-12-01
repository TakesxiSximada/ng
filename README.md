# Makefiles to create the environment

## INSTALL

```
$ export NG_ROOT=$PWD/home/src/ng
$ mkdir -p $NG_ROOT
$ git clone git@github.com:TakesxiSximada/ng.git $NG_ROOT
$ cp $NG_ROOT/ng.mk.example ng.mk
$ ln -s ng.mk Makefile
```

## HOW TO USE IT

### Create environment

```
$ make create
```

### Show Usage

```
$ make
* help

      display usage

* conda

      Install conda environent

* create


* config


* gisting

      Load gisting script

* gvm

      Install gvm

* nvm

      Install nvm

* perlbrew

      Install perlbrew (BUT IT DOES NOT WORKING)

* rbenv

      Install rbenv

* ruby-build

      Install ruby-build
```


## Requires

- GNU Make
- unmake https://github.com/TakesxiSximada/unmake

