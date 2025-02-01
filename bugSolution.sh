#!/bin/bash

# This script demonstrates a solution to the race condition bug using a lock file.

# Create two files
touch file1.txt
touch file2.txt

# Function to write to a file with locking
write_to_file() {
  local file=$1
  local message=$2
  # Acquire lock
  flock $lockfile
  echo "$message" > "$file"
  # Release lock
  flock -u $lockfile
}

# Create a lock file
lockfile="my.lock"

# Start two processes simultaneously to write to these files using the function
(write_to_file file1.txt "Process 1" & pid1=$!) 
(write_to_file file2.txt "Process 2" & pid2=$!)

# Wait for both processes to finish
wait $pid1 $pid2

# Print the contents of both files
cat file1.txt
cat file2.txt

# remove lock file
rm $lockfile