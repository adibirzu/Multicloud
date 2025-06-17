#!/bin/bash

set -e

echo "🔎 Detecting OS..."
OS="$(uname -s)"

install_oci_cli() {
  echo "📦 Installing OCI CLI..."

  bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)" -- \
    --accept-all-defaults --install-dir "$HOME/oci-cli"
  echo 'export PATH="$HOME/oci-cli/bin:$PATH"' >> ~/.bashrc
  echo 'export PATH="$HOME/oci-cli/bin:$PATH"' >> ~/.zshrc
}

if [[ "$OS" == "Darwin" ]]; then
  echo "🟦 Installing on macOS..."

  brew update

  brew install azure-cli
  brew install --cask google-cloud-sdk

  curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
  sudo installer -pkg AWSCLIV2.pkg -target /
  rm -f AWSCLIV2.pkg

  install_oci_cli

elif [[ -f /etc/os-release ]]; then
  . /etc/os-release
  if [[ "$ID" == "ubuntu" || "$ID_LIKE" == *"debian"* ]]; then
    echo "🟩 Installing on Ubuntu..."

    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

    sudo apt-get install -y apt-transport-https ca-certificates gnupg curl
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | \
      sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
      gpg --dearmor | sudo tee /usr/share/keyrings/cloud.google.gpg > /dev/null
    sudo apt-get update && sudo apt-get install -y google-cloud-cli

    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip -q awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip

    install_oci_cli

  elif [[ "$ID" == "ol" || "$ID_LIKE" == *"rhel"* ]]; then
    echo "🟥 Installing on Oracle Linux..."

    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | \
    sudo tee /etc/yum.repos.d/azure-cli.repo
    sudo dnf install -y azure-cli

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

    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip -q awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip

    install_oci_cli
  fi
else
  echo "❌ Unsupported OS."
  exit 1
fi

echo "✅ All CLIs installed!"
echo "Next steps:"
echo "  - az login"
echo "  - gcloud init"
echo "  - aws configure"
echo "  - oci setup config"
