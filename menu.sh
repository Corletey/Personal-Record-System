#!/bin/bash

# Function to generate a strong and random password
generate_password() {
  # Use the openssl command to generate a random password of length 16
  password=$(openssl rand -base64 16)
  echo "$password"
}

# Function to add a new record
add_record() {
  echo "Adding a New Record"

  # Collect user input for the record
  read -p "Enter username: " username
  read -p "Enter email address: " email_address

  # Generate a strong and random password for the user
  password=$(generate_password)

  # Check if the username already exists in the usernames.txt file
  if grep -q "$username" usernames.txt; then
    echo "Username already exists."
  else
    # Append the new record to the respective files
    echo "$username" >> usernames.txt
    echo "$password" >> passwords.txt
    echo "$email_address" >> email_addresses.txt

    echo "Record added successfully!"
    echo "Generated password: $password"
  fi
}

# Function to edit an existing record
edit_record() {
  echo "Editing an Existing Record"

  # Collect user input to identify the record
  read -p "Enter username to edit: " target_username

  # Check if the username exists in the usernames.txt file
  if grep -q "$target_username" usernames.txt; then
    # Collect new data for the record
    read -p "Enter new username: " new_username
    read -p "Enter new email address: " new_email

    # Update the record in the respective files
    sed -i "/$target_username/c$new_username" usernames.txt
    sed -i "/$target_username/c$new_email" email_addresses.txt

    echo "Record updated successfully!"
  else
    echo "Username not found."
 fi
}

# Function to search for a record by username or email address
search_record() {
  echo "Searching for a Record"

  # Collect user input to search for the record
  read -p "Enter search term (username or email address): " search_term

  # Search for the record in the respective files and display the results
  if grep -q "$search_term" usernames.txt; then
    echo "Record found in usernames.txt:"
    grep "$search_term" usernames.txt
  elif grep -q "$search_term" email_addresses.txt; then
    echo "Record found in email_addresses.txt:"
    grep "$search_term" email_addresses.txt
  else
    echo "Record not found."
 fi
}

# Function to generate a report of all records in the system
generate_report() {
  echo "Generating Report"

  # Use the paste command to combine the contents of the three files into a single report file, separated by tabs.
  paste usernames.txt passwords.txt email_addresses.txt > report.txt

  # Display the contents of the report file using column command for better readability.
  column -t -s $'\t' report.txt

}

# Function to create regular backups of personal record files.
create_backup() {
	echo "Creating Backup"

	# Create a backup directory if it doesn't exist.
	if [ ! -d backup ]; then mkdir backup; fi

	# Create a timestamp for backup files.
	timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

	# Copy personal record files into backup directory with timestamp.
	cp usernames.txt backup/usernames_$timestamp.bak
	cp passwords.txt backup/passwords_$timestamp.bak
	cp email_addresses.txt backup/email_addresses_$timestamp.bak

	echo "Backup created successfully!"
}

# Display the main menu and handle user choices using a while loop.
while true; do
	echo ""
	echo "Personal Record Management System"
	echo "-----------------------------"
	echo "1. Add a new record"
	echo "2. Edit an existing record"
	echo "3. Search for a record"
	echo "4. Generate a report"
	echo "5. Create Backup"
	echo "6. Exit"

	# Get user's choice and call appropriate function.
	read -p "Enter your choice: " choice

	case $choice in
		1) add_record ;;
		2) edit_record ;;
		3) search_record ;;
		4) generate_report ;;
		5) create_backup ;;
		6) break ;;
		*) echo "Invalid choice." ;;
	esac
done

echo ""
echo "Exiting Personal Record Management System. Goodbye!"

