#!/bin/sh

echo 'Setting up your Mac...'

# Install Brew.
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Brew recipes.
brew update

brew install git

# clone this repo to the required dir
git clone https://github.com/Loruz/dotfiles.git ~/dotfiles

cd ~/dotfiles

# Install Brewfile bundle.
brew tap homebrew/bundle
brew bundle

# Start mariadb whenever mac starts.
brew services start mariadb

# Oh-My-Zsh.
sudo rm -rf ~/.oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/bash_aliases ~/.bash_aliases

# Set default shell.
echo "$(which zsh)" >> /etc/shells
chsh -s $(which zsh)

# Install and configure Valet.
composer global require laravel/valet
sudo valet install

echo ''
echo 'Done!'

