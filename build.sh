#!/bin/bash

# Define the source and output paths
SOURCE_FILE="src/pages/index.md"
OUTPUT_DIR="dist"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Convert Markdown to PDF
pandoc "$SOURCE_FILE" -o "$OUTPUT_DIR/my-cv.pdf" --pdf-engine=xelatex

# Convert Markdown to LaTeX
pandoc "$SOURCE_FILE" -o "$OUTPUT_DIR/my-cv.tex"

echo "PDF and LaTeX files generated in $OUTPUT_DIR"

# Make the script executable
chmod +x build.sh
