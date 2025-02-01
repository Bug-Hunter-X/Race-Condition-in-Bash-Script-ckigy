#!/bin/bash

# This script demonstrates a race condition bug.

# Create two files
touch file1.txt
touch file2.txt

# Start two processes simultaneously to write to these files
(echo "Process 1" > file1.txt & pid1=$!) 
(echo "Process 2" > file2.txt & pid2=$!)

# Wait for both processes to finish
wait $pid1 $pid2

# Print the contents of both files
cat file1.txt
cat file2.txt