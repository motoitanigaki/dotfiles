#!/bin/bash

origin_dir=~/.dotfiles/settings
home_dir=$(eval echo ~)

echo "Original directory: $origin_dir"

find "$origin_dir" -type f | while read file
do
    echo "Processing file: $file"
    target="${file/#$origin_dir/$home_dir}"    
    echo "Target link will be: $target"
    target_dir=$(dirname "$target")
    echo "Target directory is: $target_dir"
    mkdir -p "$target_dir"
    ln -sf "$file" "$target"
    echo "Symbolic link created"
done
