#!/bin/bash

# Directory path containing the images
directory=$1

# Check if the argument - the directory path with images - is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

# function to convert a file to webp format
convert_to_webp() {
    local file="$1"
    cwebp -q 85 "$file" -o "${file%.*}.webp"
}

# Function to optimize GIF images to webp format
optimize_gif() {
    local file="$1"
    gif2webp "$file" -q 85 -m 6 -mt -o "${file%.*}.webp"
}

# function to AVIF format
convert_to_avif() {
    local file="$1"
    convert "$file" -quality 85 "${file%.*}.avif"
}

optimize_jpg() {
    local file="$1"

    # Оптимизировать JPEG
    jpegoptim --max=90 --strip-all "$file"

    convert_to_webp "$file"
    convert_to_avif "$file"
}

# It removes the transparent area around the image
trim_png() {
    local file="$1"
    convert "$file" -trim "$file"
}

optimize_png() {
    local file="$1"
    trim_png "$file"
    pngquant 32 --quality 40-80 --strip --speed 1 "$file" --force --output "$file" -v
    convert_to_webp "$file"
    convert_to_avif "$file"
}

optimize_svg() {
    local file="$1"
    svgo --multipass "$file"
}

# Function to optimize images based on their file format
optimize_image() {
    local file="$1"

    case "$file" in
        *.jpg|*.jpeg)
            optimize_jpg "$file"
            ;;
        *.png)
            optimize_png "$file"
            ;;
        *.svg)
            optimize_svg "$file"
            ;;
        *.gif)
            optimize_gif "$file"
            ;;
        *)
            echo "Unsupported file format: $file"
            ;;
    esac
}

# Function to process files
process_image() {
    local file="$1"
    local filename=$(basename -- "$file")
    local dirname=$(dirname -- "$file")

    # Create the originals directory within the directory containing the image if it doesn't exist
    mkdir -p "$dirname/originals"

    # Check if the file is already optimized and presented in originals directory, then do nothing
    if [ -f "$dirname/originals/$filename" ]; then
        return
    fi

    # Copy original JPEG files to the originals directory if they don't already exist
    if [ ! -f "$dirname/originals/$filename" ]; then
        cp "$file" "$dirname/originals/"
    fi

    # Optimize the image
    optimize_image "$file"
}

# Find all JPEG files in the specified directory and its subdirectories,
# excluding files whose path contains '/originals/'
find "$directory" -type f \( -iname "*.jpg" -o -iname "*.jpeg" \) ! -path "*/originals/*" | while read -r file; do
    process_image "$file"
done

# Find all SVG files in the specified directory and its subdirectories
# excluding files whose path contains '/originals/'
find "$directory" -type f -name "*.svg" ! -path "*/originals/*" | while read -r file; do
    process_image "$file"
done

# Find all PNG files in the specified directory and its subdirectories
# excluding files whose path contains '/originals/'
find "$directory" -type f -name "*.png" ! -path "*/originals/*" | while read -r file; do
    process_image "$file"
done

# Find all GIF files in the specified directory and its subdirectories
# excluding files whose path contains '/originals/'
find "$directory" -type f -name "*.gif" ! -path "*/originals/*" | while read -r file; do
    process_image "$file"
done
