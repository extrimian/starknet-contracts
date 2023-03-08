#!/bin/bash

SELECTOR="$(python proxy_script.py initializer)"

if [ -z "$1" ]
then
echo "Error: a salting number as an input is required"
echo "Usage: ${0} SALT_NUMBER"
exit 1
fi
./compile.sh

cd ..


echo "Declaring proxy"
PROXY_CLASS_HASH="$(starknet declare --contract compiled/Proxy.json  | grep 'Contract class' | grep -o '[[:digit:]].*$')"
echo "Proxy contract class hash: ${PROXY_CLASS_HASH}"
echo "Declaring v0"
SIDETREE_CONTRACT_HASH="$(starknet declare --contract compiled/sidetree_v0.json  | grep 'Contract class' | grep -o '[[:digit:]].*$')"
echo "Sidetree contract class hash: ${SIDETREE_CONTRACT_HASH}"

echo "Deploying contract"


