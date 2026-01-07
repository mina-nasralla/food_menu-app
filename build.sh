#!/bin/bash
set -e

# Add Flutter to PATH
export PATH="$PATH:$PWD/flutter/bin"

# Verify Flutter is available
echo "Flutter version:"
flutter --version

# Build the web app
echo "Building Flutter web app..."
flutter build web --release

echo "Build complete!"
