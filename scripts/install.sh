#!/bin/sh

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Ensure the brew command is available
if ! command -v brew &> /dev/null; then
    echo "Brew command is not found. Please check the Homebrew installation."
    exit 1
fi

# Update Homebrew
brew update

# Install packages from Brewfile
if [ -f ./Brewfile ]; then
    echo "Found Brewfile. Installing packages..."
    brew bundle
else
    echo "Brewfile is not found in the current directory."
fi