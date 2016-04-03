#!/bin/bash
# vim: ts=4:sw=4:et

JLENV_HOME=${JLENV_HOME:-$HOME/.jlenv}

if [ ! -d $JLENV_HOME ]
then
    mkdir $JLENV_HOME
fi

function lsjlenv() {
    for env in $(find $JLENV_HOME -name \*.env -type d | sort)
    do
        basename ${env} .env
    done
}

function mkjlenv() {
    env=$1
    if [ -d "$JLENV_HOME/${env}.env" ]
    then
        echo "Virtual environment already exists: '$env'"
        return 1
    fi
    if [ -z "$env" ]
    then
        echo "USAGE: mkjlenv <virtualenv_name>"
        return 1
    fi

    echo "Creating Julia virtual environment '$env'"
    mkdir "$JLENV_HOME/${env}.env"
    JULIA_PKGDIR="$JLENV_HOME/${env}.env" julia -e 'Pkg.init()'
    jlworkon $env
}

function rmjlenv() {
    env=$1
    if [ ! -d "$JLENV_HOME/${env}.env" ]
    then
        echo "Not a virtual environment: '$env'"
        return 1
    fi

    echo "Removing Julia virtual environment '$env'"
    rm -rf "$JLENV_HOME/${env}.env"
}


function jlworkon() {
    env=$1
    if [ ! -d "$JLENV_HOME/${env}.env" ]
    then
        echo "Not a virtual environment: '$env'"
        return 1
    fi
    export __VENV_JL_OLD_PKGDIR=$JULIA_PKGDIR
    export JULIA_PKGDIR="$JLENV_HOME/${env}.env"
    export JULIA_VENV=$env
    export __VENV_JL_OLD_PS1=$PS1
    export PS1="($JULIA_VENV)$PS1"
}

function jldeactivate() {
    unset JULIA_VENV
    export JULIA_PKGDIR="$__VENV_JL_OLD_PKGDIR"
    unset __VENV_JL_OLD_PKGDIR
    export PS1="$__VENV_JL_OLD_PS1"
    unset __VENV_JL_OLD_PS1
}
