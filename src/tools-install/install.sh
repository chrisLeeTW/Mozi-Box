#!/usr/bin/env sh

export TERRAFORM_VERSION=0.11.7

# upgrade apk tools
apk add --no-cache --upgrade apk-tools

# install dependencies & bultin-tools
apk add --no-cache python2 py2-pip jq git bash docker ruby ruby-bundler zip

# install terraform
cd /tmp || exit 1
wget -O ./terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip ./terraform.zip
mv terraform /usr/local/bin
chmod +x /usr/local/bin/terraform
rm ./terraform.zip

# install test-kitchen
cd /tmp/dist/tools-install/test-kitchen || exit 1
apk add --no-cache --virtual .ruby-builddeps ruby-dev build-base
bundle install --clean --no-cache -j5
apk del .ruby-builddeps

# install bitbucket-cli
mv /tmp/dist/bitbucket-cli /usr/local/bin
chmod +x /usr/local/bin/bitbucket-cli

# pip upgrade
pip install --upgrade pip

# install deployfish & ext
pip install file:///tmp/dist/deployfish-ext-0.0.1.tar.gz

# install batchbeagle
cd /tmp || exit 1
git clone https://github.com/caltechads/batchbeagle.git
cd batchbeagle || exit 1
python setup.py install

# cleanup
rm -rf /tmp/dist /tmp/batchbeagle
