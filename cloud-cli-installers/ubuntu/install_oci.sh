#!/bin/bash
echo "🔧 Installing OCI CLI on Ubuntu..."
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
echo "✅ OCI CLI installed. Run 'oci setup config' to initialize"
