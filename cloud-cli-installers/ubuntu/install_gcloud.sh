#!/bin/bash
echo "🔧 Installing Google Cloud CLI on Ubuntu..."
sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates gnupg curl
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/cloud.google.gpg > /dev/null
sudo apt-get update && sudo apt-get install -y google-cloud-cli
echo "✅ Done. Run 'gcloud init'"
