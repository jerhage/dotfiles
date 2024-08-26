#!/bin/bash

# Function to print usage
print_usage() {
    echo "Usage: $0 [-r output_name] [-h] <input_file>"
    echo "Convert a file to UTF-8 encoding"
    echo
    echo "Options:"
    echo "  -r output_name    Specify the output file name (without extension)"
    echo "  -h, --help        Display this help message"
    exit 1
}

# Initialize variables
output_name=""

# Parse command line options
while [[ $# -gt 0 ]]; do
    case $1 in
    -r)
        output_name="$2"
        shift 2
        ;;
    -h | --help)
        print_usage
        ;;
    *)
        break
        ;;
    esac
done

# Shift the options so that $1 is the input file
shift $((OPTIND - 1))

# Check if a file is provided as an argument
if [ $# -eq 0 ]; then
    print_usage
fi

# Get the input filename
input_file="$1"

# Check if the file exists
if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found."
    exit 1
fi

# Detect the encoding using uchardet
detected_encoding=$(uchardet "$input_file")

# Check if uchardet was successful
if [ $? -ne 0 ]; then
    echo "Error: Unable to detect encoding."
    exit 1
fi

# Get the file extension
file_extension="${input_file##*.}"

# Create the output filename
if [ -n "$output_name" ]; then
    output_file="${output_name}.${file_extension}"
else
    output_file="${input_file%.*}_utf8.${file_extension}"
fi

# Convert the file to UTF-8 using iconv
iconv -f "$detected_encoding" -t UTF-8 "$input_file" >"$output_file"

# Check if iconv was successful
if [ $? -eq 0 ]; then
    echo "Conversion successful. Output file: $output_file"
else
    echo "Error: Conversion failed."
    exit 1
fi
