#!/bin/bash

# Create main directories
mkdir -p src/{auth,web_scraper,gpt_agent,asana_integration,notion_integration,memory,utils}
mkdir config

# Create app.py file
touch app.py

# Create __init__.py files in each src subdirectory
for dir in src/*/ ; do
    touch "${dir}__init__.py"
done

# Create a requirements.txt file
touch requirements.txt

# Print out the structure
echo "Project structure created:"
tree -L 2
