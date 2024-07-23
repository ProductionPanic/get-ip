#!/bin/bash
# this script installs the get-ip script
REPO_URL="https://github.com/ProductionPanic/get-ip.git"
INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="get-ip"

CURRENT_PATH=$(pwd)

# check if the script is already installed
RESPONSE=$(which $SCRIPT_NAME)
if [ -n "$RESPONSE" ]; then
    echo "The script is already installed"
    exit 1
fi

# check if go is installed
RESPONSE=$(which go)
if [ -z "$RESPONSE" ]; then
    echo "Go is not installed. Please install go and try again"
    exit 1
fi

# check if git is installed
RESPONSE=$(which git)
if [ -z "$RESPONSE" ]; then
    echo "Git is not installed. Please install git and try again"
    exit 1
fi

# clone the repo
git clone $REPO_URL /tmp/get-ip
cd /tmp/get-ip

# build the script
go build -o $SCRIPT_NAME

# set the permissions
chmod +x $SCRIPT_NAME

# move the script to the install directory
mv $SCRIPT_NAME $INSTALL_DIR

# clean up
cd $CURRENT_PATH
rm -rf /tmp/get-ip

echo "The script has been installed successfully"
