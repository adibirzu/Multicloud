#!/bin/bash
echo "🔧 Installing AWS CLI v2 on macOS..."
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
rm AWSCLIV2.pkg
echo "✅ AWS CLI installed. Run 'aws configure'"
