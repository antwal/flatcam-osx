#!/bin/bash

# set -e

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then

    case "${OS_BUILD}" in
        brew)
            # Force update homebrew
            cd "$(brew --repo)"
            git fetch
            git reset --hard origin/master

            if [[ $OS_VERSION == '10.12' ]]; then
                git -C "/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core" fetch --unshallow
            fi

            brew update --force
            cd ~/
            ;;
    esac

fi
