#!/bin/bash
# Generate a random password
password=$(pwgen -s 12 1)
# Print the password to the user
echo $password
