#!/bin/bash

TEMPLATE_PATH="$HOME/documents/share/template"

# display help messages if there isn't enough variables
if [ $1 -eq "" ]; then
	echo "Invalid options specified"
fi

if [ $2 -eq "" ]; then
	echo "Invalid options specified"
fi

if [ $1 -eq "-h" ]; then
	echo "Project template maker"
	echo "create-project.sh <template_name> <folder_location>"
fi

# copy all files from target to destination
echo "Using template: $1"
echo "Copying to: $2"

mkdir $2
cp -R $TEMPLATE_PATH/$1/* "$2"
