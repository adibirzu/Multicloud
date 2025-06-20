#!/bin/bash

set -e

echo "🌐 Multi-Cloud CLI Installer: Azure + GCP + AWS + OCI"
echo "🔎 Detecting platform..."

OS="$(uname -s)"

install_oci_cli() {
  echo "📦 Installing OCI CLI..."
  bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)" -- \
    --accept-all-defaults --install-dir "$HOME/oci-cli"
  export PATH="$HOME/oci-cli/bin:$PATH"
  echo 'export PATH="$HOME/oci-cli/bin:$PATH"' >> ~/.bashrc
  echo 'export PATH="$HOME/oci-cli/bin:$PATH"' >> ~/.zshrc
}

if [[ "$OS" == "Darwin" ]]; then
  echo "🟦 Detected macOS"

  echo "🔄 Updating Homebrew..."
  brew update

  echo "📦 Installing Azure CLI..."
  brew install azure-cli

  echo "📦 Installing Google Cloud SDK..."
  brew install --cask google-cloud-sdk

  echo "📦 Installing AWS CLI v2..."
  curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
  sudo installer -pkg AWSCLIV2.pkg -target /
  rm -f AWSCLIV2.pkg

  install_oci_cli

elif [[ -f /etc/os-release ]]; then
  . /etc/os-release
  if [[ "$ID" == "ubuntu" || "$ID_LIKE" == *"debian"* ]]; then
    echo "🟩 Detected Ubuntu/Debian"

    echo "📦 Installing dependencies..."
    sudo apt-get update
    sudo apt-get install -y unzip apt-transport-https ca-certificates gnupg curl

    echo "📦 Installing Azure CLI..."
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

    echo "📦 Installing Google Cloud SDK..."
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | \
      sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
      gpg --dearmor | sudo tee /usr/share/keyrings/cloud.google.gpg > /dev/null
    sudo apt-get update && sudo apt-get install -y google-cloud-cli

    echo "📦 Installing AWS CLI v2..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip -q awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip

    install_oci_cli

  elif [[ "$ID" == "ol" || "$ID_LIKE" == *"rhel"* ]]; then
    echo "🟥 Detected Oracle Linux / RHEL"

    echo "📦 Installing dependencies..."
    sudo dnf install -y unzip curl

    echo "📦 Installing Azure CLI..."
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | \
      sudo tee /etc/yum.repos.d/azure-cli.repo
    sudo dnf install -y azure-cli

    echo "📦 Installing Google Cloud SDK..."
    sudo tee /etc/yum.repos.d/google-cloud-sdk.repo <<EOF
[google-cloud-cli]
name=Google Cloud CLI
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el8-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
    sudo dnf install -y google-cloud-cli

    echo "📦 Installing AWS CLI v2..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip -q awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip

    install_oci_cli
  else
    echo "❌ Unsupported Linux distribution: $ID"
    exit 1
  fi
else
  echo "❌ Unsupported operating system: $OS"
  exit 1
fi

echo ""
echo "✅ All CLIs installed successfully!"
echo ""
echo "👉 Next steps:"
echo "   az login"
echo "   gcloud init"
echo "   aws configure"
echo "   oci setup config"
