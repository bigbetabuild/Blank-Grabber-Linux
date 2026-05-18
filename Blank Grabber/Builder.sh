#!/bin/bash

cd "$(dirname "$0")"

# Check if Python is installed
echo "Checking Python installation..."
if ! command -v python3 &> /dev/null; then
    echo "Python 3 is not installed!"
    echo "Please install Python 3.10+ from https://www.python.org/downloads/"
    exit 1
fi

# Get Python version
PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:3])))')
echo "Python version: $PYTHON_VERSION"

# Check for Python 3.10+
REQUIRED_VERSION="3.10"
if [[ $(printf '%s\n' "$REQUIRED_VERSION" "$PYTHON_VERSION" | sort -V | head -n1) != "$REQUIRED_VERSION" ]]; then
    echo "Your Python version is $PYTHON_VERSION but version 3.10+ is required!"
    exit 1
fi

# Install required libraries
echo "Checking and installing required libraries..."

echo "Checking 'customtkinter' (1/4)"
python3 -c "import customtkinter" 2>/dev/null || {
    echo "Installing customtkinter..."
    pip install customtkinter
}

echo "Checking 'pillow' (2/4)"
python3 -c "import PIL" 2>/dev/null || {
    echo "Installing pillow..."
    pip install pillow
}

echo "Checking 'pyaes' (3/4)"
python3 -c "import pyaes" 2>/dev/null || {
    echo "Installing pyaes..."
    pip install pyaes
}

echo "Checking 'urllib3' (4/4)"
python3 -c "import urllib3" 2>/dev/null || {
    echo "Installing urllib3..."
    pip install urllib3
}

clear
echo "Starting builder..."
python3 gui.py

exit $?
