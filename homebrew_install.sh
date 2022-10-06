#!/bin/bash

echo "installing homebrew..."
which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "run brew doctor..."
which brew >/dev/null 2>&1 && brew doctor

echo "run brew update..."
which brew >/dev/null 2>&1 && brew update

echo "ok. run brew upgrade..."

brew upgrade --all

formulas=(
    git
    node
    pkg-config
    apr-util
    hub
    nodebrew
    readline
    autoconf
    icu4c
    oniguruma
    sqlite
    exa
    jq
    openssl@1.1	starship
    fish
    lz4
    pandoc
    tree
    gettext
    m4
    pcre2
    utf8proc
    ghq
    ncurses
    peco
    yarn
    z
)

"brew tap..."
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php
brew tap homebrew/apache
brew tap sanemat/font

echo "start brew install apps..."
for formula in "${formulas[@]}"; do
    brew install $formula || brew upgrade $formula
done

casks=(
    alfred
    clipy
    CotEditor
    DeepL
    Dropbox
    Firefox
    Flux
    HyperSwitch
    google-chrome
    google-japanese-ime
    sourcetree
    iterm2
    ImageOptim
    Karabiner-Elements
    KeyboardCleanTool
    MAMP
    OnyX
    Sourcetree
    Spark
    Spectacle
    Transmit
    Typora
    Visual-Studio-Code
    Vivaldi
    Xcode
)

echo "start brew cask install apps..."
for cask in "${casks[@]}"; do
    brew install $cask
done

brew cleanup
brew cask cleanup

cat << END

**************************************************
HOMEBREW INSTALLED! bye.
**************************************************

END
