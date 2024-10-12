#!/bin/bash

# Navigate to the project directory
cd "$(dirname "$0")"

# Activate the virtual environment
source myenv/bin/activate

# Print a message to confirm activation
echo "Virtual environment activated. You're now working on your project!"

# Start a new shell session
exec $SHELL
