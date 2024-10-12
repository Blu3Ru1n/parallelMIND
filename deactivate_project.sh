#!/bin/bash

# Deactivate the virtual environment
deactivate

# Print a message to confirm deactivation
echo "Virtual environment deactivated. You're now using your system Python environment."

# Start a new shell session
exec $SHELL
