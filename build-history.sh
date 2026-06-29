#!/bin/bash
set -e
echo "🚀 Building stash/cherry-pick practice environment..."
mkdir -p src
echo "// Main app" > src/main.js
git add src/main.js
git commit -m "Initial commit"
echo "✅ Setup complete! Start with EXERCISES.md"
