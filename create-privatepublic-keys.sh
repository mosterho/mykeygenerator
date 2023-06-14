#!/bin/bash

#set -x      #uncomment this to display more detail from the execution of each line below

echo ""
echo "Delete existing public and private keys, CSR, etc."
rm Results/*.*

echo ""
echo "Generating private key..."
openssl genpkey -algorithm RSA -out ./Results/private.key

echo ""
echo "Generating public key..."
openssl pkey -in ./Results/private.key -pubout -out ./Results/publickey.pem

echo ""
echo "Generating text of public section of private key and public key..."
openssl pkey -in ./Results/private.key -pubout  -out ./Results/publicdata-of-privatekey.txt
openssl pkey -in ./Results/publickey.pem -pubin -out ./Results/publickey.txt

echo ""
echo "Comparing (using DIFF) text of public section of private key and public key..."
diff -s ./Results/publickey.txt ./Results/publicdata-of-privatekey.txt

## creating a CSR here will also produce an encrypted (password) private key,
## but on screen only (with these arguments)
echo ""
echo "creating new CSR from private key... stand by for prompts!"
openssl req -new -in ./Results/private.key -out ./Results/privatekey-encrypted-pem.csr -config ./CNF/ESIS-CA-request.cnf
##openssl req -new -in ./Results/private.key -out ./Results/privatekey-encrypted.pem

echo ""
echo "Verifying CSR..."
openssl req -in ./Results/privatekey-encrypted-pem.csr -text -verify -noout

#echo "Sleeping for 600 seconds, CTRL-c when ready to close this window."
#sleep 600
