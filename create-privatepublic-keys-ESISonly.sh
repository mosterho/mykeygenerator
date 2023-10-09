#!/bin/bash

#set -x      #uncomment this to display more detail from the execution of each line below

echo ""
echo "Delete existing public and private keys, CSR, etc."
rm ESIS/*.*


## creating a CSR here will prompt for an encrypted (password) private key,
## but on screen only (with these arguments) do not enter a passphrase!
echo ""
echo "creating new CSR AND NEW ADDITIONAL private key based on ESIS prompts... stand by for prompts!"
echo "this will create a key file qwithout the passphrase as well"
openssl req -new  -keyout ./ESIS/private-simplified.key  -out ./ESIS/privatekey-encrypted-pem-simplified.csr -config ./CNF/ESIS-CA-request.cnf
echo "Re-enter the passphrase for the key just created to generate the new additional key without the passphrase"
openssl rsa -in           ./ESIS/private-simplified.key  -out ./ESIS/private-simplified-nophrase.key

echo ""
echo "Verifying CSR..."
openssl req -in ./ESIS/privatekey-encrypted-pem-simplified.csr -text -verify -noout

