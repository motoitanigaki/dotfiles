#!/bin/bash

origin_dir=~/.dotfiles/settings

find "$origin_dir" -type f | while read file
do
    target="${file/#$origin_dir/~}"
    mkdir -p "$(dirname "$target")"
    ln -sf "$file" "$target"
done