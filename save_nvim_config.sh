#!/bin/bash

# Source directory
source_dir="$HOME/.config/nvim"

# Destination directory
destination_dir="$HOME/.local/share/chezmoi/dot_config/nvim"

# Check if source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Source directory $source_dir does not exist."
    exit 1
fi

# Create destination directory if it doesn't exist
mkdir -p "$destination_dir"

# Copy files recursively
cp -r "$source_dir"/* "$destination_dir"

echo "Files copied from $source_dir to $destination_dir successfully."

