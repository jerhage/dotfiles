#!/bin/bash
# TODO: allow for passing in encoding if already known
# error message if system does not have uchardet installed
# allow for passing in directory to save to

# Function to print usage
print_usage() {
    echo "Usage: $0 [-o output] [-f input_encoding] [-h] <input_file>"
    echo "Convert a file to UTF-8 encoding"
    echo
    echo "Options:"
    echo "  -o output         Specify the output file name (without extension)"
    echo "  -f, --from encoding Specify the input file encoding (skips auto-detection)"
    echo "  -h, --help        Display this help message"
    exit 1
}

# Initialize variables
output_name=""
input_encoding=""
# Parse command line options
while [[ $# -gt 0 ]]; do
    case $1 in
    -o)
        output_name="$2"
        shift 2
        ;;
    -f | --from)
        input_encoding="$2"
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

# Detect or use provided encoding
if [ -z "$input_encoding" ]; then
    # Check if uchardet is installed
    if ! command -v uchardet &>/dev/null; then
        echo "Error: uchardet is not installed. Please install it or use the -f flag to specify the input encoding."
        exit 1
    fi

    # Detect the encoding using uchardet
    detected_encoding=$(uchardet "$input_file")

    # Check if uchardet was successful
    if [ $? -ne 0 ]; then
        echo "Error: Unable to detect encoding."
        exit 1
    fi
else
    detected_encoding="$input_encoding"
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
