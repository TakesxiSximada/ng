gist-create() {
    _GIST_DESCRIPTION=$1
    _GIST_DIRNAME=$2
    echo "# $_GIST_DESCRIPTION" > /tmp/README.md
    _GIST_URL=`gist -d "$_GIST_DESCRIPTION" /tmp/README.md`
    git submodule add $(echo $_GIST_URL | gawk 'match($0, /https:\/\/gist.github.com\/(.+)/, data) {print "git@gist.github.com:" data[1] ".git"}') $_GIST_DIRNAME
    git submodule update
    git commit -m "add gist $_GIST_URL"
    echo $_GIST_DIRNAME
}

gist-create-single() {
    _GIST_DESCRIPTION=$1
    echo "$_GIST_DESCRIPTION" > /tmp/README.md
    _GIST_URL=`gist -d "$_GIST_DESCRIPTION" /tmp/README.md`
    git clone $(echo $_GIST_URL | gawk 'match($0, /https:\/\/gist.github.com\/(.+)/, data) {print "git@gist.github.com:" data[1] ".git"}')
}

gist-sync() {
    git commit -m "update gist"
    git push
    if [ -e ../.git ]
    then
        _GIST_DIRNAME=$(basename $PWD)
        cd .. && git add $_GIST_DIRNAME && git commit -m "update gist" $_GIST_DIRNAME  && git push
        cd $_GIST_DIRNAME
    fi
}

gist-list() {
    head -n 1 */README.md
}
