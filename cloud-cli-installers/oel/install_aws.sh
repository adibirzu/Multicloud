#!/bin/bash
echo "🔧 Installing AWS CLI v2 on Oracle Linux..."
sudo dnf install -y unzip curl
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
sudo ./aws/install
rm -rf aws awscliv2.zip
echo "✅ AWS CLI installed. Run 'aws configure'"
