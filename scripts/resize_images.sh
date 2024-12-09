#!/bin/bash

# Directory path containing the images
directory=$1

# Check if the argument - the directory path with images - is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

# Function to resize image if width > 1000 px
resize_image() {
    local file="$1"
    local filename=$(basename -- "$file")
    local dirname=$(dirname -- "$file")

    # Create the originals directory within the directory containing the image if it doesn't exist
    mkdir -p "$dirname/originals"

    # Check if the file is already saved in the originals directory, then skip
    if [ -f "$dirname/originals/$filename" ]; then
        echo "Skipping $file (already saved in originals)."
        return
    fi

    # Copy the original file to the originals directory
    cp "$file" "$dirname/originals/"

    # Check the width of the image
    local width=$(magick identify -format "%w" "$file")

    # Resize the image if width > 1000 px
    if [ "$width" -gt 1000 ]; then
        echo "Resizing $file (current width: $width px)..."
        magick convert "$file" -resize 1000x "$file"
        echo "$file resized to 1000 px width."
    else
        echo "Skipping $file (width: $width px)."
    fi
}

# Find all image files in the specified directory
find "$directory" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | while read -r file; do
    resize_image "$file"
done
