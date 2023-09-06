#!/bin/bash
# Get the current date and time
date=$(date +"%Y-%m-%d-%H-%M-%S")
# Create a backup of the personal record file
cp personal_records.txt "personal_records_$date.txt"
# Print a message to the user
echo "Backup created successfully."
