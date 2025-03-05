#!/bin/bash

# Define paths
SOURCE_FILE="src/pages/index.md"  # Adjust if it’s still `my-cv.md`
OUTPUT_DIR="public/downloads"

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# Function to run Pandoc natively
run_pandoc_native() {
  pandoc "$SOURCE_FILE" -o "$OUTPUT_DIR/my-cv.pdf" --pdf-engine=xelatex || {
    echo "Error: PDF conversion failed"
    exit 1
  }
  pandoc "$SOURCE_FILE" -o "$OUTPUT_DIR/my-cv.tex" || {
    echo "Error: TeX conversion failed"
    exit 1
  }
}

# Function to run Pandoc via Docker
run_pandoc_docker() {
  docker run --rm -v "$(pwd):/data" pandoc/latex:latest-ubuntu \
    pandoc /data/"$SOURCE_FILE" -o /data/"$OUTPUT_DIR/my-cv.pdf" --pdf-engine=xelatex || {
    echo "Error: PDF conversion failed with Docker"
    exit 1
  }
  docker run --rm -v "$(pwd):/data" pandoc/latex:latest-ubuntu \
    pandoc /data/"$SOURCE_FILE" -o /data/"$OUTPUT_DIR/my-cv.tex" || {
    echo "Error: TeX conversion failed with Docker"
    exit 1
  }
}

# Check if running inside a Docker container (prod case)
if [ -f /.dockerenv ] || grep -q docker /proc/1/cgroup 2>/dev/null; then
  # Inside Docker (GitHub Actions), use native Pandoc
  echo "Running natively in Docker environment (prod)"
  run_pandoc_native
else
  # Outside Docker (dev case), check if Pandoc is installed locally
  if command -v pandoc >/dev/null 2>&1 && command -v xelatex >/dev/null 2>&1; then
    echo "Running natively in dev (Pandoc and XeLaTeX found)"
    run_pandoc_native
  else
    echo "Pandoc or XeLaTeX not found locally, using Docker in dev"
    run_pandoc_docker
  fi
fi

echo "PDF and LaTeX files generated in $OUTPUT_DIR"