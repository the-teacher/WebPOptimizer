#!/bin/bash

# Directory path containing the PDF files
directory=$1

# Check if the argument - the directory path with PDFs - is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

# Function to process PDF files
process_pdf() {
    local file="$1"
    local filename=$(basename -- "$file")
    local dirname=$(dirname -- "$file")
    local name_without_ext="${filename%.*}"

    # Create a directory for images extracted from the PDF
    local output_dir="$dirname/${name_without_ext}_images"
    mkdir -p "$output_dir"

    # Convert each page of the PDF to a JPEG image
    echo "Processing $file..."
    convert -density 300 "$file" "$output_dir/${name_without_ext}_page_%03d.jpg"
}

# Find all PDF files in the specified directory and its subdirectories
find "$directory" -type f -name "*.pdf" | while read -r file; do
    process_pdf "$file"
done