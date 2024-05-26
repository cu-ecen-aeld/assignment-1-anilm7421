#!/bin/bash

# Check if arguments are provided
if [ $# -ne 2 ]; then
    echo "Error: Please provide filesdir and searchstr"
    exit 1
fi

filesdir=$1
searchstr=$2

# Check if filesdir exists and is a directory
if [ ! -d "$filesdir" ]; then
    echo "Error: $filesdir is not a directory"
    exit 1
fi

# Function to count matching lines in a file
count_matching_lines() {
    local file="$1"
    local searchstr="$2"
    local count=0
    count=$(grep -c "$searchstr" "$file")
    echo "$count"
}

# Function to recursively search for files and count matching lines
search_files() {
    local dir="$1"
    local searchstr="$2"
    local file_count=0
    local line_count=0

    while IFS= read -r -d '' file; do
        file_count=$((file_count + 1))
        matching_lines=$(count_matching_lines "$file" "$searchstr")
        line_count=$((line_count + matching_lines))
    done < <(find "$dir" -type f -print0)

    echo "The number of files are $file_count and the number of matching lines are $line_count"
}

search_files "$filesdir" "$searchstr"