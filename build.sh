#!/bin/bash

# Define the source and output paths
SOURCE_FILE="src/pages/index.md"
OUTPUT_DIR="dist"
PUBLIC_DIR="public"


# Create the output directories if they don't exist
mkdir -p "$OUTPUT_DIR"
mkdir -p "$PUBLIC_DIR"

# Convert Markdown to PDF
pandoc "$SOURCE_FILE" -o "$OUTPUT_DIR/my-cv.pdf" --pdf-engine=xelatex

# Convert Markdown to LaTeX
pandoc "$SOURCE_FILE" -o "$OUTPUT_DIR/my-cv.tex"

# Copy files to public directory for development
cp "$OUTPUT_DIR/my-cv.pdf" "$PUBLIC_DIR/"
cp "$OUTPUT_DIR/my-cv.tex" "$PUBLIC_DIR/"

echo "PDF and LaTeX files generated in $OUTPUT_DIR and copied to $PUBLIC_DIR"

# Make the script executable
chmod +x build.sh
