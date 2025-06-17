#!/bin/bash
echo "🔧 Installing Azure CLI on macOS using Homebrew..."
brew update && brew install azure-cli
echo "✅ Done. Run 'az login' to authenticate."
