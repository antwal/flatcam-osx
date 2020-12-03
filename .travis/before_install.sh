#!/bin/bash

# set -e

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then

    case "${OS_BUILD}" in
        brew)
            # Install some custom requirements on OS X from brew
            # Force update homebrew
            cd "$(brew --repo)"
            git fetch
            git reset --hard origin/master
            brew update --force
            cd ~/
            ;;
    esac

fi
