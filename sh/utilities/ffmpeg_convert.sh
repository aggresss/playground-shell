#!/usr/bin/env bash

# Check for required argument
if [ $# -eq 0 ]; then
    echo "Error: You must specify a target directory as an argument"
    echo "Usage: $0 <target_directory>"
    exit 1
fi

# Get the input directory
INPUT_DIR="$1"

# Verify directory exists
if [ ! -d "$INPUT_DIR" ]; then
    echo "Error: Directory '$INPUT_DIR' does not exist"
    exit 1
fi

# Set output directory (optional, defaults to overwriting original files)
OUTPUT_DIR="converted"
mkdir -p "$OUTPUT_DIR"

# Change to the target directory
pushd "$INPUT_DIR" > /dev/null || exit 1

# Process all .wav files in directory and subdirectories
find . -type f -iname "*.wav" | while read -r input_file; do
    # Generate output path (preserving relative directory structure)
    output_file=$(echo $INPUT_DIR/$OUTPUT_DIR/${input_file#./} | tr \'[:upper:]\' \'[:lower:]\')

    # Create directory structure for output file
    mkdir -p "$(dirname "$output_file")"

    # Execute conversion command
    ffmpeg -i "$input_file" -map_metadata -1 -fflags +bitexact -c:a pcm_s16le -ac 1 -ar 16000 -b:a 512k -y "$output_file"

    echo "Converted: $input_file → $output_file"
done

# Return to original directory
popd > /dev/null || exit 1

echo "All files converted successfully! Output directory: $OUTPUT_DIR"
