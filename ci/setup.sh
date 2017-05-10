#!/usr/bin/env bash

# Installing dependencies - AWS CLI
pip install --quiet --upgrade awscli pip

# Install Terraform, Packer, jq and hub
mkdir -p ~/bin/{$TF_VERSION,$PACKER_VERSION,$JQ_VERSION,$HUB_VERSION}
if [[ ! -e ~/bin/${TF_VERSION}/terraform ]]; then wget --no-verbose https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -O t.zip && unzip -qq t.zip -d ~/bin/${TF_VERSION}; fi
if [[ ! -e ~/bin/${PACKER_VERSION}/packer ]]; then wget --no-verbose https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O p.zip && unzip -qq p.zip -d ~/bin/${PACKER_VERSION}; fi
if [[ ! -e ~/bin/${JQ_VERSION}/jq ]]; then wget --no-verbose https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 -O ~/bin/${JQ_VERSION}/jq && chmod +x ~/bin/${JQ_VERSION}/jq; fi
if [[ ! -e ~/bin/${HUB_VERSION}/hub ]]; then wget --no-verbose https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz -O h.tgz && tar xzf h.tgz && mv hub-linux-amd64-${HUB_VERSION}/bin/hub ~/bin/${HUB_VERSION}/; fi

# Print versions
echo
aws --version
terraform version
packer version
jq --version
hub --version
echo
